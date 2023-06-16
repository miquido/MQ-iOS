import MQ
import XCTest

final class MultipleIssuesTests: XCTestCase {

	func test_errors_isEmpty_withoutInitialErrors() {
		let multipleIssues: MultipleIssues = .error()

		XCTAssertTrue(multipleIssues.errors.isEmpty)
	}

	func test_errors_containsInitialErrors_withoutInitialErrorsProvided() {
		let multipleIssues: MultipleIssues = .error(collecting: Undefined.error())

		XCTAssertTrue(multipleIssues.errors.contains(where: { $0 is Undefined }))
	}

	func test_add_appendsErrorToCollection() {
		var multipleIssues: MultipleIssues = .error()

		multipleIssues.add(Undefined.error())

		XCTAssertTrue(multipleIssues.errors.contains(where: { $0 is Undefined }))
	}

	func test_displayableString_usesProvidedExtractionFunction() {
		let multipleIssues: MultipleIssues = .error(
			displayableMessageExtraction: { _ in "MOCK" }
		)

		XCTAssertEqual(multipleIssues.displayableString, "MOCK")
	}
}
