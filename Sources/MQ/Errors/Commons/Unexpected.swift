/// ``TheError`` for unexpected errors.
///
/// ``Unexpected`` error can occur when some unexpected failure occurs.
/// It is meant to be used as a default error for cases where the error is not expected
/// or as a fallback for cases where occurring error is not matching expected criteria.
public struct Unexpected: TheError {

	/// Create instance of ``Unexpected`` error.
	///
	/// - Parameters:
	///   - message: Message associated with this error.
	///   Default value is "Unexpected".
	///   - group: ``TheErrorGroup`` associated with this error instance.
	///   Default value is ``TheErrorGroup.default``.
	///   - underlyingError: Optional instance of error which was not expected.
	///   This value will not be collected in release builds.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: New instance of ``Unexpected`` error with given context.
	public static func error(
		message: StaticString = "Unexpected",
		group: TheErrorGroup = .default,
		underlyingError: Error?,
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
				.with(underlyingError, for: "underlyingError"),
			group: .merging(group, (underlyingError as? TheError)?.group ?? [])
		)
	}

	/// Source code context of this error.
	public var context: SourceCodeContext
	/// Error group associated with this error instance.
	public var group: TheErrorGroup
}
