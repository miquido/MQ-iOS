/// ``TheError`` for type mismatch errors.
public struct TypeMismatch: TheError {

	/// Create instance of ``TypeMismatch`` error.
	///
	/// - Parameters:
	///   - message: Message associated with this error.
	///   Default value is "TypeMismatch".
	///   - displayableMessage: Message which can be displayed
	///   to the end user. Default value is based on ``TheErrorDisplayableMessages``.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: New instance of ``TypeMismatch`` error with given context.
	public static func error(
		message: StaticString,
		displayableMessage: DisplayableString = TheErrorDisplayableMessages.message(for: Self.self),
		type: Any.Type,
		file: StaticString = #fileID,
		line: UInt = #line
	) -> Self {
		Self(
			context: .context(
				message: message,
				file: file,
				line: line
			),
			displayableString: displayableMessage,
			type: type
		)
	}

	/// Source code context of this error.
	public var context: SourceCodeContext
	/// String representation displayable to the end user.
	public var displayableString: DisplayableString
	/// Type that was required.
	public let type: Any.Type
}
