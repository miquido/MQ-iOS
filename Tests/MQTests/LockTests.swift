import MQ
import XCTest

final class LockTests: XCTestCase {

	func test_init_doesNotModifyLockState() {
		var result: Void?
		let _: Lock = .init(
			acquire: { result = void },
			tryAcquire: {
				result = void
				return false
			},
			release: { result = void }
		)

		XCTAssertNil(result)
	}

	func test_lock_callsAcquire() {
		var result: Void?
		let lock: Lock = .init(
			acquire: { result = void },
			tryAcquire: unimplemented(),
			release: unimplemented()
		)

		lock.lock()

		XCTAssertNotNil(result)
	}

	func test_unlock_callsRelease() {
		var result: Void?
		let lock: Lock = .init(
			acquire: unimplemented(),
			tryAcquire: unimplemented(),
			release: { result = void }
		)

		lock.unlock()

		XCTAssertNotNil(result)
	}

	func test_trylock_callsTryAcquire() {
		var result: Void?
		let lock: Lock = .init(
			acquire: unimplemented(),
			tryAcquire: {
				result = void
				return false
			},
			release: unimplemented()
		)

		_ = lock.tryLock()

		XCTAssertNotNil(result)
	}

	func test_trylock_returnsTryAcquireResult() {
		var result: Bool?
		let lock: Lock = .init(
			acquire: unimplemented(),
			tryAcquire: always(false),
			release: unimplemented()
		)

		result = lock.tryLock()

		XCTAssertEqual(result, false)
	}

	func test_withLock_acquiresLockBeforeExecutingTask() {
		var result: Void?
		let lock: Lock = .init(
			acquire: { result = void },
			tryAcquire: unimplemented(),
			release: noop
		)

		lock
			.withLock {
				XCTAssertNotNil(result)
			}
	}

	func test_withLock_acquiresLockAfterExecutingTask() {
		var result: Void?
		let lock: Lock = .init(
			acquire: noop,
			tryAcquire: unimplemented(),
			release: { result = void }
		)

		lock
			.withLock {
				XCTAssertNil(result)
			}

		XCTAssertNotNil(result)
	}
}
