/// ``TheError`` for type mismatch errors.
public struct TypeMismatch: TheError {

	/// Create instance of ``TypeMismatch`` error.
	///
	/// - Parameters:
	///   - message: Message associated with this error.
	///   Default value is "TypeMismatch".
	///   - group: ``TheErrorGroup`` associated with this error instance.
	///   Default value is ``TheErrorGroup.default``.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: New instance of ``TypeMismatch`` error with given context.
	public static func error(
		message: StaticString,
		group: TheErrorGroup = .default,
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
			group: group,
			type: type
		)
	}

	/// Source code context of this error.
	public var context: SourceCodeContext
	/// Error group associated with this error instance.
	public var group: TheErrorGroup
	/// Type that was required.
	public let type: Any.Type
}
