import MQ
import XCTest

final class LockTests: XCTestCase {

	final class FakeSendableState: @unchecked Sendable {

		var result: Void? = .none
	}

	var fakeSendableState: FakeSendableState!

	override func setUp() {
		super.setUp()
		self.fakeSendableState = .init()
	}

	override func tearDown() {
		self.fakeSendableState = .none
		super.tearDown()
	}

	func test_init_doesNotModifyLockState() {
		let _: Lock = .init(
			acquire: {
				self.fakeSendableState.result = void
			},
			tryAcquire: {
				self.fakeSendableState.result = void
				return false
			},
			release: {
				self.fakeSendableState.result = void
			}
		)

		XCTAssertNil(self.fakeSendableState.result)
	}

	func test_lock_callsAcquire() {
		let lock: Lock = .init(
			acquire: {
				self.fakeSendableState.result = void
			},
			tryAcquire: unimplemented(),
			release: unimplemented()
		)

		lock.lock()

		XCTAssertNotNil(self.fakeSendableState.result)
	}

	func test_unlock_callsRelease() {
		let lock: Lock = .init(
			acquire: unimplemented(),
			tryAcquire: unimplemented(),
			release: {
				self.fakeSendableState.result = void
			}
		)

		lock.unlock()

		XCTAssertNotNil(self.fakeSendableState.result)
	}

	func test_trylock_callsTryAcquire() {
		let lock: Lock = .init(
			acquire: unimplemented(),
			tryAcquire: {
				self.fakeSendableState.result = void
				return false
			},
			release: unimplemented()
		)

		_ = lock.tryLock()

		XCTAssertNotNil(self.fakeSendableState.result)
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
		let lock: Lock = .init(
			acquire: {
				self.fakeSendableState.result = void
			},
			tryAcquire: unimplemented(),
			release: noop
		)

		lock
			.withLock {
				XCTAssertNotNil(self.fakeSendableState.result)
			}
	}

	func test_withLock_acquiresLockAfterExecutingTask() {
		let lock: Lock = .init(
			acquire: noop,
			tryAcquire: unimplemented(),
			release: {
				self.fakeSendableState.result = void
			}
		)

		lock
			.withLock {
				XCTAssertNil(self.fakeSendableState.result)
			}

		XCTAssertNotNil(self.fakeSendableState.result)
	}
}
