import MQ
import XCTest

final class LockTests: XCTestCase {

	func test_init_doesNotModifyLockState() {
		var result: Void?
		let _: Lock = .init(
			acquire: { result = void },
			acquireBefore: { _ in result = void
				return false
			},
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
			acquireBefore: unimplemented(),
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
			acquireBefore: unimplemented(),
			tryAcquire: unimplemented(),
			release: { result = void }
		)

		lock.unlock()

		XCTAssertNotNil(result)
	}

	func test_lockBefore_callsAcquireBefore() {
		var result: Void?
		let lock: Lock = .init(
			acquire: unimplemented(),
			acquireBefore: { _ in result = void
				return false
			},
			tryAcquire: unimplemented(),
			release: unimplemented()
		)

		_ = lock.lock(before: 0)

		XCTAssertNotNil(result)
	}

	func test_lockBefore_returnsAcquireBeforeResult() {
		var result: Bool?
		let lock: Lock = .init(
			acquire: unimplemented(),
			acquireBefore: always(false),
			tryAcquire: unimplemented(),
			release: unimplemented()
		)

		result = lock.lock(before: 0)

		XCTAssertEqual(result, false)
	}

	func test_trylock_callsTryAcquire() {
		var result: Void?
		let lock: Lock = .init(
			acquire: unimplemented(),
			acquireBefore: unimplemented(),
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
			acquireBefore: unimplemented(),
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
			acquireBefore: unimplemented(),
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
			acquireBefore: unimplemented(),
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
