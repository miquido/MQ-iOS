extension Error {

	/// Convert any error to ``TheError``.
	///
	/// If the error is already instance of ``TheError`` it will be returned without changes.
	/// ``CancellationError`` will be automatically converted to ``Cancelled``.
	/// Any other error is converted using custom conversion method or
	/// becomes converted to ``Unidentified``.
	///
	/// - Parameters:
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	///   - customConversion: Optional custom conversion of errors from ``Unidentified``.
	///   Default implementation returns received ``Unidentified`` without any changes.
	/// - Returns: Error converted to ``TheError``.
	@inlinable @inline(__always)
	@Sendable public func asTheError(
		file: StaticString = #fileID,
		line: UInt = #line,
		customConversion: (Unidentified) -> TheError = { $0 }
	) -> TheError {
		switch self {
		case let theError as TheError:
			return theError

		case let convertible as TheErrorConvertible:
			return convertible
				.convertToTheError(
					file: file,
					line: line
				)

		case let error:
			return customConversion(
				Unidentified
					.error(
						message: "Unidentified: Error type conversion from `Swift.Error`",
						underlyingError: error,
						file: file,
						line: line
					)
			)
		}
	}
}
