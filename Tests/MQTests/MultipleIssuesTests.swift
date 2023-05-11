import MQ
import XCTest

final class MultipleIssuesTests: XCTestCase {

	func test_errors_isEmpty_withoutInitialErrors() async throws {
		let multipleIssues: MultipleIssues = .error()

		XCTAssertTrue(multipleIssues.errors.isEmpty)
	}

	func test_errors_containsInitialErrors_withoutInitialErrorsProvided() async throws {
		let multipleIssues: MultipleIssues = .error(collecting: Undefined.error())

		XCTAssertTrue(multipleIssues.errors.contains(where: { $0 is Undefined }))
	}

	func test_add_appendsErrorToCollection() async throws {
		var multipleIssues: MultipleIssues = .error()

		multipleIssues.add(Undefined.error())

		XCTAssertTrue(multipleIssues.errors.contains(where: { $0 is Undefined }))
	}

	func test_merge_doesNotAddErrorToCollection() async throws {
		var multipleIssues: MultipleIssues = .error()

		multipleIssues.merge(with: Undefined.error())

		XCTAssertTrue(multipleIssues.errors.isEmpty)
	}

	func test_displayableString_usesProvidedExtractionFunction() async throws {
		let multipleIssues: MultipleIssues = .error(
			displayableMessageExtraction: { _ in "MOCK" }
		)

		XCTAssertEqual(multipleIssues.displayableString, "MOCK")
	}
}
