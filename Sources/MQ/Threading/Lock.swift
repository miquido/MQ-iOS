/// Abstraction over locking.
///
/// ``Lock`` interface can be used as an abstraction over any locking mechanism.
/// Its specific behavior depends on concrete implementation of a lock.
@frozen public struct Lock {

	// Acquire the lock waiting indefinetly if needed.
	@usableFromInline internal let acquire: () -> Void
	// Try acquire the lock if able.
	// Returns `true` if acquiring lock succeed and `false` otherwise.
	@usableFromInline internal let tryAcquire: () -> Bool
	// Release the lock if able.
	@usableFromInline internal let release: () -> Void

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
	///   - tryAcquire: Function used to acquire the lock if able aka try lock.
	///   Locking should occur if possible and not block current thread.
	///   Function should return `true` when locking succeeded or `false` otherwise.
	///   - release: Function used to release the lock aka unlock.
	///   It should have no effect when lock was not acquired and unlock otherwhise.
	public init(
		acquire: @escaping () -> Void,
		tryAcquire: @escaping () -> Bool,
		release: @escaping () -> Void
	) {
		self.acquire = acquire
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
	@inlinable public func lock() {
		self.acquire()
	}

	/// Try acquire the lock if able.
	///
	/// This method tries to acquire the lock if able.
	/// It passes without waiting if it was not able to acquire the lock at the moment of call.
	///
	/// - Returns: `true` if acquiring lock succeed and `false` otherwise.
	@inlinable public func tryLock() -> Bool {
		self.tryAcquire()
	}

	/// Release the lock if able.
	///
	/// Release this lock if it has been previously acquired.
	/// It will unlock execution in one of points waiting for acquire.
	/// Exact behaviour depends on concrete implementation of a lock.
	@inlinable public func unlock() {
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
	@inlinable public func withLock<Result>(
		_ execute: () throws -> Result
	) rethrows -> Result {
		self.lock()
		defer { self.unlock() }
		return try execute()
	}
}
