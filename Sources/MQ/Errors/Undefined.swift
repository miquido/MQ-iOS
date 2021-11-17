/// ``TheError`` for undefined errors.
///
/// ``Undefined`` error can occur when some undefined failure occurs.
/// It is ment to be used as a default error for cases where cause of failure is not defined.
public struct Undefined: TheError {

	/// Create instance of ``Undefined`` error.
	///
	/// - Parameters:
	///   - message: Message associated with this error.
	///   Default value is "Undefined".
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: New instance of ``Undefined`` error with given context.
	public static func error(
		message: StaticString = "Undefined",
		file: StaticString = #fileID,
		line: UInt = #line
	) -> Self {
		Self(
			context: .context(
				message: message,
				file: file,
				line: line
			)
		)
	}

	/// Source code context of this error.
	public var context: SourceCodeContext
}
