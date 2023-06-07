/// ``TheError`` for corrupted data errors.
public struct DataCorrupted: TheError {

	/// Create instance of ``DataCorrupted`` error.
	///
	/// - Parameters:
	///   - message: Message associated with this error.
	///   Default value is "DataCorrupted".
	///   - displayableMessage: Message which can be displayed
	///   to the end user. Default value is based on ``TheErrorDisplayableMessages``.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: New instance of ``DataCorrupted`` error with given context.
	public static func error(
		message: StaticString,
		displayableMessage: DisplayableString = TheErrorDisplayableMessages.message(for: Self.self),
		file: StaticString = #fileID,
		line: UInt = #line
	) -> Self {
		Self(
			context: .context(
				message: message,
				file: file,
				line: line
			),
			displayableString: displayableMessage
		)
	}

	/// Source code context of this error.
	public var context: SourceCodeContext
	/// String representation displayable to the end user.
	public var displayableString: DisplayableString
}
