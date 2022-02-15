extension Error {

	/// Convert any error to ``TheError``.
	///
	/// If the error is already instance of ``TheError`` it will be returned
	/// with additional diagnostics added.
	/// ``CancellationError`` is converted to ``Cancelled``.
	/// Any other error is converted to ``Unidentified``.
	///
	/// - Parameters:
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: Error converted to ``TheError``.
	public func asTheError(
		file: StaticString = #fileID,
		line: UInt = #line
	) -> TheError {
		let convertedError: TheError
		switch self {
		case let theError as TheError:
			convertedError = theError

		case let cancellation as CancellationError:
			convertedError =
				Cancelled
				.error(
					file: file,
					line: line
				)
				.with(cancellation, for: "sourceError")

		case let error:
			convertedError =
				Unidentified
				.error(
					underlyingError: error,
					file: file,
					line: line
				)
		}

		return
			convertedError
			.appending(
				.context(
					message: "Error type conversion from `Swift.Error`"
				)
				.with(file, for: "file")
				.with(line, for: "line")
			)
	}
}
