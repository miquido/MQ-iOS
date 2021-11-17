import struct Darwin.time_t

/// Abstraction over locking.
///
/// ``Lock`` interface can be used as an abstraction over any locking mechanism.
/// Its specific behavior depends on concrete implementation of a lock.
public struct Lock {

	// Acquire the lock waiting indefinetly if needed.
	private var acquire: () -> Void
	// Acquire the lock before given deadline while waiting or continue.
	// Deadline argument is epoch time in nanoseconds
	// which is number of nanoseconds from January 1st 1970.
	// Deadline verification depends on concrete implementation of a lock.
	// Returns `true` if acquiring lock succeed and `false` otherwise.
	private var acquireBefore: (UInt64) -> Bool
	// Try acquire the lock if able.
	// Returns `true` if acquiring lock succeed and `false` otherwise.
	private var tryAcquire: () -> Bool
	// Release the lock if able.
	private var release: () -> Void

	/// Initialize lock using provided method implementations.
	///
	/// Create instance of ``Lock`` backed by provided implementation.
	///
	/// - Note: When providing custom implementation you have to ensure its correctness.
	/// You can verify common threading problems by running your program with
	/// thread sanitizer enabled.
	///
	/// - Parameters:
	///   - acquire: Function used to acquire the lock aka lock.
	///   Function should block current thread until lock becomes acquired.
	///   - acquireBefore: Function used to acquire the lock before given deadline
	///   aka lock before. Locking should occur before provided deadline.
	///   Function should block current thread until lock becomes acquired or deadline passes.
	///   Deadline time is represented by epoch time in nanoseconds
	///   which is number of nanoseconds from January 1st 1970.
	///   Function should return `true` when locking succeeded or `false` otherwise.
	///   - tryAcquire: Function used to acquire the lock if able aka try lock.
	///   Locking should occur if possible and not block current thread.
	///   Function should return `true` when locking succeeded or `false` otherwise.
	///   - release: Function used to release the lock aka unlock.
	///   It should have no effect when lock was not acquired and unlock otherwhise.
	public init(
		acquire: @escaping () -> Void,
		acquireBefore: @escaping (UInt64) -> Bool,
		tryAcquire: @escaping () -> Bool,
		release: @escaping () -> Void
	) {
		self.acquire = acquire
		self.acquireBefore = acquireBefore
		self.tryAcquire = tryAcquire
		self.release = release
	}
}

extension Lock {

	/// Acquire the lock.
	///
	/// This method call will block current thread until lock becomes acquired.
	///
	/// - warning: This method will never timeout. It will wait for acquiring the lock indefinetly.
	public func lock() {
		self.acquire()
	}

	/// Acquire the lock with given deadline requirement.
	///
	/// This method call will block current thread until lock becomes acquired
	/// or dedline requirement fails. Thread execution will be continued
	/// without acquiring the lock after the deadline time.
	///
	/// - warning: This method will continue thread execution
	/// without acquiring the lock when deadline requirement fails.
	///
	/// - Parameter deadline: Deadline for acquiring the lock.
	/// Representerd by epoch time nanoseconds
	/// which is number of nanoseconds from January 1st 1970.
	///
	/// - Returns: `true` if acquiring lock was successful, `false` otherwise.
	public func lock(
		before deadline: UInt64
	) -> Bool {
		self.acquireBefore(deadline)
	}

	/// Try acquire the lock if able.
	///
	/// This method tries to acquire the lock if able.
	/// It passes without waiting if it was not able to acquire the lock at the moment of call.
	///
	/// - Returns: `true` if acquiring lock succeed and `false` otherwise.
	public func tryLock() -> Bool {
		self.tryAcquire()
	}

	/// Release the lock if able.
	///
	/// Release this lock if it has been previously acquired.
	/// It will unlock execution in one of points waiting for acquire.
	/// Exact behaviour depends on concrete implementation of a lock.
	public func unlock() {
		self.release()
	}
}

extension Lock {

	/// Acquire this lock for the scope of provided function.
	///
	/// - Parameter execute: Function to be executed under the lock.
	/// - Returns: Value returned from provided function execution.
	///
	/// - warning: Nested invocation may cause deadlock.
	/// Ensure that used lock implementation is recursive or avoid recursive usage.
	public func withLock<Result>(
		_ execute: () throws -> Result
	) rethrows -> Result {
		self.lock()
		defer { self.unlock() }
		return try execute()
	}
}

#if canImport(Foundation)

	import struct Foundation.Date
	import struct Foundation.TimeInterval
	import class Foundation.NSLock
	import class Foundation.NSRecursiveLock

	extension Lock {

		/// Crate an instance of ``Lock`` backed by provided ``NSLock`` instance.
		///
		/// This method can be used to create both new locks and to wrap existing instances of ``NSLock``.
		///
		/// - Parameter lock: Instance of ``NSLock`` that will be used to perform locking.
		/// New instance of ``NSLock`` is made as a default argument.
		/// - Returns: Instance of ``Lock`` using provided ``NSLock``.
		///
		/// - note: ``NSLock`` is not recursive.
		public static func nsLock(
			_ lock: NSLock = .init()
		) -> Self {
			Self(
				acquire: lock.lock,
				acquireBefore: { time in
					lock.lock(
						before: .init(
							timeIntervalSince1970: TimeInterval(nanosec: time)
						)
					)
				},
				tryAcquire: lock.try,
				release: lock.unlock
			)
		}

		/// Crate an instance of ``Lock`` backed by provided ``NSRecursiveLock`` instance.
		///
		/// This method can be used to create both new locks and to wrap existing instances of ``NSRecursiveLock``.
		///
		/// - Parameter lock: Instance of ``NSRecursiveLock`` that will be used to perform locking.
		/// New instance of ``NSRecursiveLock`` is made as a default argument.
		/// - Returns: Instance of ``Lock`` using provided ``NSRecursiveLock``.
		public static func nsRecursiveLock(
			_ lock: NSRecursiveLock = .init()
		) -> Self {
			Self(
				acquire: lock.lock,
				acquireBefore: { time in
					lock.lock(
						before: .init(
							timeIntervalSince1970: TimeInterval(nanosec: time)
						)
					)
				},
				tryAcquire: lock.try,
				release: lock.unlock
			)
		}
	}
#endif

extension TimeInterval {

	fileprivate init(nanosec: UInt64) {
		self.init(nanosec * 1_000_000_000)
	}
}
