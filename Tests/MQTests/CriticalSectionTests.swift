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
}
