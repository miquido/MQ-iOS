import MQ
import XCTest

final class TheErrorTests: XCTestCase {

	func test_merge_combinesSourceCodeContext() {
		let error: MultipleIssues = .error(
			collecting: Undefined.error(
				file: "file",
				line: 42
			),
			Unimplemented
				.error(
					file: "other_file",
					line: 0
				)
		)

		XCTAssertEqual(
			error.context,
			.context(
				message: "Undefined",
				file: "file",
				line: 42
			)
			.appending(
				.message(
					"Unimplemented",
					file: "other_file",
					line: 0
				)
			)
		)
	}
}
