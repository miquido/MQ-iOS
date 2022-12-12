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
public final class CriticalSection<State>: @unchecked Sendable
where State: Sendable {

	@usableFromInline internal let statePointer: UnsafeMutablePointer<State>
	@usableFromInline internal let lockPointer: UnsafeMutablePointer<os_unfair_lock>
	private let cleanup: @Sendable (State) -> Void

	/// Initialize ``CriticalSection`` with given initial state.
	///
	/// - Parameters:
	///   - state: Initial state.
	///   - cleanup: Code executed on deallocation.
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

	/// Access a property from ``CriticalSection`` state.
	///
	/// Retrieve current value of selected property
	/// from ``CriticalSection`` state.
	///
	/// - Note: This method can wait for gathering exclusive access to the memory.
	///
	/// - Parameter keyPath: Key path used to access a property
	/// inside ``CriticalSection`` state.
	/// - Returns: Value associated with requested key path.
	@_disfavoredOverload
	@inlinable @Sendable public func access<Value>(
		_ keyPath: KeyPath<State, Value>
	) -> Value {
		os_unfair_lock_lock(self.lockPointer)
		defer { os_unfair_lock_unlock(self.lockPointer) }
		return self.statePointer.pointee[keyPath: keyPath]
	}

	/// Assign property value in ``CriticalSection`` state.
	///
	/// Set given value under selected property
	/// in ``CriticalSection`` state.
	///
	/// - Note: This method can wait for gathering exclusive access to the memory.
	///
	/// - Parameters
	///   - keyPath: Key path used to access a property
	/// inside ``CriticalSection`` state.
	///   value: Value assigned under requested key path.
	@inlinable @Sendable public func assign<Value>(
		_ keyPath: WritableKeyPath<State, Value>,
		_ value: Value
	) {
		os_unfair_lock_lock(self.lockPointer)
		defer { os_unfair_lock_unlock(self.lockPointer) }
		self.statePointer.pointee[keyPath: keyPath] = value
	}

	/// Gain exclusive access to ``CriticalSection`` memory.
	///
	/// Exclusive access to critical section has to be
	/// as short as possible and cannot be recursive.
	///
	/// - Parameter access: Function executed with exclusive access to
	/// ``CriticalSection`` memory allowing to mutate it and get its state.
	/// Value returned from this function will be used as a result
	/// of access to ``CriticalSection`` memory.
	/// - Returns: Value returned from provided access function.
	@inlinable @Sendable public func access<Value>(
		@_inheritActorContext _ access: @Sendable (inout State) throws -> Value
	) rethrows -> Value {
		os_unfair_lock_lock(self.lockPointer)
		defer { os_unfair_lock_unlock(self.lockPointer) }
		return try access(&self.statePointer.pointee)
	}
}
