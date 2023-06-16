/// ``TheError`` for key not found errors.
public struct KeyNotFound<Key>: TheError {

	/// Create instance of ``KeyNotFound`` error.
	///
	/// - Parameters:
	///   - message: Message associated with this error.
	///   Default value is "KeyNotFound".
	///   - group: ``TheErrorGroup`` associated with this error instance.
	///   Default value is ``TheErrorGroup.default``.
	///   - key: Missing key.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: New instance of ``KeyNotFound`` error with given context.
	public static func error(
		message: StaticString,
		group: TheErrorGroup = .default,
		key: Key,
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
			key: key
		)
	}

	/// Source code context of this error.
	public var context: SourceCodeContext
	/// Error group associated with this error instance.
	public var group: TheErrorGroup
	/// Missing key.
	public let key: Key
}
