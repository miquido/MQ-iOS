/// ``TheError`` for internal application state issues.
///
/// ``InternalInconsistency`` error can occur when application state is invalid.
public struct InternalInconsistency: TheError {

	/// Create instance of ``InternalInconsistency`` error.
	///
	/// - Parameters:
	///   - message: Message associated with this error.
	///   - group: ``TheErrorGroup`` associated with this error instance.
	///   Default value is ``TheErrorGroup.default``.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: New instance of ``InternalInconsistency`` error with given context.
	public static func error(
		message: StaticString,
		group: TheErrorGroup = .default,
		file: StaticString = #fileID,
		line: UInt = #line
	) -> Self {
		Self(
			context: .context(
				message: message,
				file: file,
				line: line
			),
			group: group
		)
	}

	/// Source code context of this error.
	public var context: SourceCodeContext
	/// Error group associated with this error instance.
	public var group: TheErrorGroup
}
