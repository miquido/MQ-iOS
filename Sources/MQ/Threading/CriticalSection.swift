import struct libkern.atomic_flag
import func libkern.atomic_flag_clear
import func libkern.atomic_flag_test_and_set

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
public struct CriticalSection<State> {

	@usableFromInline internal let memory: Memory

	/// Initialize ``CriticalSection`` with given initial state.
	///
	/// - Property state: Initial state.
	public init(
		_ state: State
	) {
		self.memory = .init(state)
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
	@inlinable public func access<Value>(
		_ keyPath: KeyPath<State, Value>
	) -> Value {
		while !atomic_flag_test_and_set(self.memory.flagPointer) {}
		defer { atomic_flag_clear(self.memory.flagPointer) }
		return self.memory.statePointer.pointee[keyPath: keyPath]
	}

	/// Gain exclusive acccess to ``CriticalSection`` memory.
	///
	/// Exclusive access to critical section has to be
	/// as short as possible and cannot be recursive.
	///
	/// - Parameter access: Function executed with exclusive access to
	/// ``CriticalSection`` memory allowing to mutate it and get its state.
	/// Value returned from this function will be used as a result
	/// of access to ``CriticalSection`` memory.
	/// - Returns: Value returned from provided access function.
	@inlinable public func access<Value>(
		_ access: (inout State) throws -> Value
	) rethrows -> Value {
		while !atomic_flag_test_and_set(self.memory.flagPointer) {}
		defer { atomic_flag_clear(self.memory.flagPointer) }
		return try access(&self.memory.statePointer.pointee)
	}
}

extension CriticalSection {

	@usableFromInline internal final class Memory {

		@usableFromInline internal let statePointer: UnsafeMutablePointer<State>
		@usableFromInline internal let flagPointer: UnsafeMutablePointer<atomic_flag>

		fileprivate init(
			_ state: State
		) {
			self.statePointer = .allocate(capacity: 1)
			self.statePointer.initialize(to: state)
			self.flagPointer = .allocate(capacity: 1)
			self.flagPointer.initialize(to: atomic_flag())
		}

		deinit {
			self.statePointer.deinitialize(count: 1)
			self.statePointer.deallocate()
			self.flagPointer.deinitialize(count: 1)
			self.flagPointer.deallocate()
		}
	}
}

extension CriticalSection: @unchecked Sendable {}
