/// ``TheError`` for cancelled operation.
///
/// ``Cancelled`` error can occur when operation was manually or automatically cancelled.
/// Associated works should not be continued but the error should not be treated as failure.
public struct Cancelled: TheError {

	/// Create instance of ``Cancelled`` error.
	///
	/// - Parameters
	///   - message: Message associated with this error.
	///   Default value is "Cancelled".
	///   - displayableMessage: Message which can be displayed
	///   to the end user. Default value is based on ``TheErrorDisplayableMessages``.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: New instance of ``Cancelled`` error with given context.
	public static func error(
		message: StaticString = "Cancelled",
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

extension Cancelled: Hashable {}
