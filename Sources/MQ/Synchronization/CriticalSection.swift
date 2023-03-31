import struct os.os_unfair_lock
import func os.os_unfair_lock_lock
import func os.os_unfair_lock_unlock

/// Mutable state which is critical section in
/// multithreaded environment.
///
/// ``CriticalSection`` provides convenience methods
/// for accessing ``CriticalSection`` state with proper
/// synchronization eliminating low level data races.
///
/// - Note: ``CriticalSection`` should not be used to provide
/// high level data synchronization over long running tasks.
/// Access method should return as quickly as possible
/// to avoid any potential issues.
/// ``CriticalSection`` cannot be used recursively.
public final class CriticalSection<State>: @unchecked Sendable
where State: Sendable {

	@usableFromInline internal let statePointer: UnsafeMutablePointer<State>
	@usableFromInline internal let lockPointer: UnsafeMutablePointer<os_unfair_lock>
	private let cleanup: @Sendable (State) -> Void

	/// Initialize ``CriticalSection`` with given initial state.
	///
	/// - Parameters:
	///   - state: Initial state.
	///   - cleanup: Optional function executed on deallocation.
	public init(
		_ state: State,
		cleanup: @escaping @Sendable (State) -> Void = { _ in }
	) {
		self.statePointer = .allocate(capacity: 1)
		self.statePointer.initialize(to: state)
		self.lockPointer = .allocate(capacity: 1)
		self.lockPointer.initialize(to: os_unfair_lock())
		self.cleanup = cleanup
	}

	deinit {
		self.cleanup(self.statePointer.pointee)
		self.statePointer.deinitialize(count: 1)
		self.statePointer.deallocate()
		self.lockPointer.deinitialize(count: 1)
		self.lockPointer.deallocate()
	}

	/// Access a value from ``CriticalSection``.
	///
	/// Retrieve current value under provided key path
	/// from ``CriticalSection``.
	///
	/// - Note: This method can wait blocking current thread
	/// in order to gather exclusive access to the memory.
	///
	/// - Parameter keyPath: Key path used to access a value
	/// inside ``CriticalSection``.
	/// - Returns: Value under provided key path.
	@inlinable @inline(__always) @_disfavoredOverload
	@Sendable public func access<Value>(
		_ keyPath: KeyPath<State, Value>
	) -> Value {
		os_unfair_lock_lock(self.lockPointer)
		defer { os_unfair_lock_unlock(self.lockPointer) }

		return self.statePointer.pointee[keyPath: keyPath]
	}

	/// Assign a value in ``CriticalSection``.
	///
	/// Assign given value under provided key path
	/// in ``CriticalSection``.
	///
	/// - Note: This method can wait blocking current thread
	/// in order to gather exclusive access to the memory.
	///
	/// - Parameters
	///   - keyPath: Key path used to assign a value
	/// inside ``CriticalSection``.
	///   - newValue: Value assigned under provided key path.
	@inlinable @inline(__always)
	@Sendable public func assign<Value>(
		_ keyPath: WritableKeyPath<State, Value>,
		_ newValue: Value
	) {
		os_unfair_lock_lock(self.lockPointer)
		defer { os_unfair_lock_unlock(self.lockPointer) }

		self.statePointer.pointee[keyPath: keyPath] = newValue
	}

	/// Gain exclusive access to ``CriticalSection``.
	///
	/// Exclusive access to critical section has to be
	/// as short as possible and cannot be recursive.
	///
	/// - Note: This method can wait blocking current thread
	/// in order to gather exclusive access to the memory.
	///
	/// - Parameter access: Function executed with exclusive access to
	/// ``CriticalSection`` allowing to mutate and retrieve its state.
	/// Value returned from provided function will be used as a
	/// result of this method call.
	/// - Returns: Value returned from provided access function.
	@inlinable @inline(__always)
	@Sendable public func access<Value>(
		_ access: (inout State) throws -> Value
	) rethrows -> Value {
		os_unfair_lock_lock(self.lockPointer)
		defer { os_unfair_lock_unlock(self.lockPointer) }

		return try access(&self.statePointer.pointee)
	}

	/// Assign a value in ``CriticalSection``
	/// while returning current.
	///
	/// - Note: This method can wait blocking current thread
	/// in order to gather exclusive access to the memory.
	///
	/// - Parameters
	///   - keyPath: Key path used to exchange a value
	/// inside ``CriticalSection``.
	///   - newValue: Value assigned under provided key path.
	/// - Returns: Value under provided key path before assignment.
	@inlinable @inline(__always)
	@Sendable public func exchange<Value>(
		_ keyPath: WritableKeyPath<State, Value>,
		with newValue: Value
	) -> Value {
		os_unfair_lock_lock(self.lockPointer)
		defer { os_unfair_lock_unlock(self.lockPointer) }

		let currentValue: Value = self.statePointer.pointee[keyPath: keyPath]
		self.statePointer.pointee[keyPath: keyPath] = newValue
		return currentValue
	}

	/// Conditionally assign a value in ``CriticalSection``.
	///
	/// - Note: This method can wait blocking current thread
	/// in order to gather exclusive access to the memory.
	///
	/// - Parameters
	///   - keyPath: Key path used to exchange a value
	/// inside ``CriticalSection`` state.
	///   - newValue: Value assigned under provided key path.
	///   - expectedValue: Value required to be present in order
	///   to perform `newValue` assignment.
	/// - Returns: `true` if assigned new value, `false` otherwise.
	@inlinable @inline(__always)
	@discardableResult @Sendable public func exchange<Value>(
		_ keyPath: WritableKeyPath<State, Value>,
		with newValue: Value,
		when expectedValue: Value
	) -> Bool
	where Value: Equatable {
		os_unfair_lock_lock(self.lockPointer)
		defer { os_unfair_lock_unlock(self.lockPointer) }

		let currentValue: Value = self.statePointer.pointee[keyPath: keyPath]

		guard currentValue == expectedValue
		else { return false }

		self.statePointer.pointee[keyPath: keyPath] = newValue

		return true
	}
}
