import Foundation

extension String {

	public init(
		_ encoding: String.Encoding = .utf8,
		from data: Data,
		file: StaticString = #fileID,
		line: UInt = #line
	) throws {
		if let string: String = .init(data: data, encoding: encoding) {
			self = string
		}
		else {
			throw StringDecodingFailure
				.error(
					for: data,
					encoding: encoding
				)
		}
	}

	public func data(
		_ encoding: String.Encoding = .utf8,
		file: StaticString = #fileID,
		line: UInt = #line
	) throws -> Data {
		if let data: Data = self.data(using: encoding) {
			return data
		}
		else {
			throw StringEncodingFailure
				.error(
					for: self,
					encoding: encoding
				)
		}
	}
}

/// ``TheError`` for string encoding failure.
///
/// ``StringEncodingFailure`` error can occur when encoding string fails.
/// It can be caused by characters that are not representable in given encoding or other issue.
public struct StringEncodingFailure: TheError {

	/// Create instance of ``StringEncodingFailure`` error.
	///
	/// - Parameters:
	///   - string: String instance causing the error.
	///   This value will not be collected in release builds.
	///   - encoding: Encoding of string causing the error.
	///   This value will not be collected in release builds.
	///   - message: Message associated with this error.
	///   Default value is "StringEncodingFailure".
	///   - group: ``TheErrorGroup`` associated with this error instance.
	///   Default value is ``TheErrorGroup.default``.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: New instance of ``StringEncodingFailure`` error with given context.
	public static func error(
		for string: String,
		encoding: String.Encoding,
		message: StaticString = "StringEncodingFailure",
		group: TheErrorGroup = .default,
		file: StaticString = #fileID,
		line: UInt = #line
	) -> Self {
		Self(
			context:
				.context(
					message: message,
					file: file,
					line: line
				)
				.with(string, for: "string")
				.with(encoding, for: "encoding"),
			group: group
		)
	}

	/// Source code context of this error.
	public var context: SourceCodeContext
	/// Error group associated with this error instance.
	public var group: TheErrorGroup
}

/// ``TheError`` for string decoding failure.
///
/// ``StringDecodingFailure`` error can occur when decoding a string from Data fails.
/// It can be caused by characters that are not representable in given encoding or other issue.
public struct StringDecodingFailure: TheError {

	/// Create instance of ``StringDecodingFailure`` error.
	///
	/// - Parameters:
	///   - data: Data instance causing the error.
	///   This value will not be collected in release builds.
	///   - encoding: String encoding causing the error.
	///   This value will not be collected in release builds.
	///   - message: Message associated with this error.
	///   Default value is "StringDecodingFailure".
	///   - group: ``TheErrorGroup`` associated with this error instance.
	///   Default value is ``TheErrorGroup.default``.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: New instance of ``StringDecodingFailure`` error with given context.
	public static func error(
		for data: Data,
		encoding: String.Encoding,
		message: StaticString = "StringDecodingFailure",
		group: TheErrorGroup = .default,
		file: StaticString = #fileID,
		line: UInt = #line
	) -> Self {
		Self(
			context:
				.context(
					message: message,
					file: file,
					line: line
				)
				.with(data.map { String($0, radix: 16) }, for: "data")
				.with(encoding, for: "encoding"),
			group: group
		)
	}

	/// Source code context of this error.
	public var context: SourceCodeContext
	/// Error group associated with this error instance.
	public var group: TheErrorGroup
}

