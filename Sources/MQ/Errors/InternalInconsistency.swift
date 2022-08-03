/// ``TheError`` for internal application state issues.
///
/// ``InternalInconsistency`` error can occur when application state is invalid.
public struct InternalInconsistency: TheError {

	/// Create instance of ``InternalInconsistency`` error.
	///
	/// - Parameters:
	///   - message: Message associated with this error.
	///   - displayableMessage: Message which can be displayed
	///   to the end user. Default is "Internal inconsistency error".
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: New instance of ``InternalInconsistency`` error with given context.
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
			displayableMessage: displayableMessage
		)
	}

	/// Source code context of this error.
	public var context: SourceCodeContext
	/// String representation displayable to the end user.
	public var displayableMessage: DisplayableString
}

extension InternalInconsistency: Hashable {}
