import MQ
import XCTest

final class CriticalSectionTests: XCTestCase {

	func test_access_synchronizesState_withConcurrentAccess() async throws {
		let state: CriticalSection<Int> = .init(0)
		for _ in 0..<10 {
			state.assign(\.self, 0)
			await withTaskGroup(of: Void.self) { group in
				for _ in 0..<100_000 {
					group.addTask {
						state.access { (value: inout Int) in
							value += 1
						}
					}
				}
				await group.waitForAll()
			}
			XCTAssertEqual(state.access(\.self), 100_000)
		}
	}

	func test_exchange_returnsCurrentAndAssignesNewValue() async throws {
		let state: CriticalSection<Int> = .init(0)
		XCTAssertEqual(
			state.exchange(\.self, with: 42),
			0
		)
		XCTAssertEqual(
			state.access(\.self),
			42
		)
	}

	func test_conditionalExchange_assignesNewValueWhenMatching() async throws {
		let state: CriticalSection<Int> = .init(0)
		XCTAssertTrue(
			state.exchange(\.self, with: 42, when: 0)
		)
		XCTAssertEqual(
			state.access(\.self),
			42
		)
	}

	func test_conditionalExchange_doesNotAssignNewValueWhenNotMatching() async throws {
		let state: CriticalSection<Int> = .init(0)
		XCTAssertFalse(
			state.exchange(\.self, with: 42, when: 1)
		)
		XCTAssertEqual(
			state.access(\.self),
			0
		)
	}
}
