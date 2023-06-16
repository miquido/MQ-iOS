/// ``TheError`` for invalid value errors.
///
/// ``InvalidValue`` error can occur when trying to use invalid value.
/// It can be use both to indicate data validation issues
/// as well as passing invalid function arguments.
public struct InvalidValue: TheError {

	/// Create instance of ``InvalidValue`` error.
	///
	/// - Parameters:
	///   - message: Message associated with this error.
	///   Should descrive validation rule which was not passing.
	///   - group: ``TheErrorGroup`` associated with this error instance.
	///   Default value is ``TheErrorGroup.default``.
	///   - value: Value which was invalid.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: New instance of ``InvalidValue`` error with given context.
	public static func error<Value>(
		message: StaticString,
		group: TheErrorGroup = .default,
		value: Value,
		file: StaticString = #fileID,
		line: UInt = #line
	) -> Self {
		Self(
			context: .context(
				message: message,
				file: file,
				line: line
			),
			group: group,
			value: value
		)
	}

	/// Source code context of this error.
	public var context: SourceCodeContext
	/// Error group associated with this error instance.
	public var group: TheErrorGroup
	/// Value which was recognized as invalid.
	public let value: Any
}
