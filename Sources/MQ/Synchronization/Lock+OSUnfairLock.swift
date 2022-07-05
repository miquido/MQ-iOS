import func os.os_unfair_lock_lock
import struct os.os_unfair_lock_s
import func os.os_unfair_lock_trylock
import func os.os_unfair_lock_unlock

extension Lock {

	/// Crate an instance of ``Lock`` backed by ``os_unfair_lock`` instance.
	///
	/// This method manages internal instance of ``os_unfair_lock``.
	///
	/// - Note: This implementation does not support recursion.
	///
	/// - Returns: Instance of ``Lock`` using ``os_unfair_lock``.
	public static func osUnfairLock() -> Self {

		final class OSUnfairLock {

			private let pointer: UnsafeMutablePointer<os_unfair_lock_s>

			fileprivate init() {
				self.pointer = .allocate(capacity: 1)
				self.pointer.initialize(to: os_unfair_lock_s())
			}

			deinit {
				self.pointer.deinitialize(count: 1)
				self.pointer.deallocate()
			}

			@inline(__always) @Sendable fileprivate func lock() {
				os_unfair_lock_lock(self.pointer)
			}

			@inline(__always) @Sendable fileprivate func tryLock() -> Bool {
				os_unfair_lock_trylock(self.pointer)
			}

			@inline(__always) @Sendable fileprivate func unlock() {
				os_unfair_lock_unlock(self.pointer)
			}
		}

		let lock: OSUnfairLock = .init()

		return Self(
			acquire: lock.lock,
			tryAcquire: lock.tryLock,
			release: lock.unlock
		)
	}
}
