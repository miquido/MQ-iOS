/// ``TheError`` for unreachable code.
///
/// ``Unreachable`` error can occur when
/// the code that supposed to be dead (inaccessible at runtime) becomes executed.
public struct Unreachable: TheError {

	/// Create instance of ``Unreachable`` error.
	///
	/// - Parameters:
	///   - message: Message associated with this error.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: New instance of ``Unreachable`` error with given context.
	public static func error(
		message: StaticString,
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

/// Convenient placeholder for unreachable code.
///
/// Placeholder for indicating unreachable part of code.
/// Terminates process with ``Unreachable`` error as the cause.
///
/// - Parameters:
///   - message: Message associated with this error.
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Never, function terminates the process.
public func unreachable(
	_ message: StaticString,
	file: StaticString = #fileID,
	line: UInt = #line
) -> Never {
	Unreachable
		.error(
			message: message,
			file: file,
			line: line
		)
		.asFatalError()
}
