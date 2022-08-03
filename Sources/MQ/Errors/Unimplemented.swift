/// ``TheError`` for unimplemented features.
///
/// ``Unimplemented`` error can occur when some feature is not implemented.
public struct Unimplemented: TheError {

	/// Create instance of ``Unimplemented`` error.
	///
	/// - Parameters:
	///   - message: Message associated with this error.
	///   Default value is "Unimplemented".
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: New instance of ``Unimplemented`` error with given context.
	public static func error(
		message: StaticString = "Unimplemented",
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

extension Unimplemented: Hashable {}

/// Convenient placeholder for unimplemented part of code.
///
/// Placeholder for indicating unimplemented part of code.
/// Terminates process with ``Unimplemented`` error as the cause.
///
/// - Parameters:
///   - message: Message associated with this error.
///   Default value is "Unimplemented".
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Never, function terminates the process.
public func unimplemented(
	_ message: StaticString = "Unimplemented",
	file: StaticString = #fileID,
	line: UInt = #line
) -> Never {
	Unimplemented
		.error(
			message: message,
			file: file,
			line: line
		)
		.asFatalError()
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   - message: Message associated with this error.
///   Default value is "Unimplemented".
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplemented<R>(
	_ message: StaticString = "Unimplemented",
	file: StaticString = #fileID,
	line: UInt = #line
) -> @Sendable () -> R {
	{
		Unimplemented
			.error(
				message: message,
				file: file,
				line: line
			)
			.asFatalError()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented part of code.
/// Throws ``Unimplemented`` when executed.
///
/// - Parameters:
///   - message: Message associated with this error.
///   Default value is "Unimplemented".
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Function throwing ``Unimplemented`` error when executed.
public func unimplementedThrowing<R>(
	_ message: StaticString = "Unimplemented",
	file: StaticString = #fileID,
	line: UInt = #line
) -> @Sendable () throws -> R {
	{
		throw
			Unimplemented
			.error(
				message: message,
				file: file,
				line: line
			)
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   - message: Message associated with this error.
///   Default value is "Unimplemented".
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplemented<A1, R>(
	_ message: StaticString = "Unimplemented",
	file: StaticString = #fileID,
	line: UInt = #line
) -> @Sendable (A1) -> R {
	{ _ in
		Unimplemented
			.error(
				message: message,
				file: file,
				line: line
			)
			.asFatalError()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented part of code.
/// Throws ``Unimplemented`` when executed.
///
/// - Parameters:
///   - message: Message associated with this error.
///   Default value is "Unimplemented".
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Function throwing ``Unimplemented`` error when executed.
public func unimplementedThrowing<A1, R>(
	_ message: StaticString = "Unimplemented",
	file: StaticString = #fileID,
	line: UInt = #line
) -> @Sendable (A1) throws -> R {
	{ _ in
		throw
			Unimplemented
			.error(
				message: message,
				file: file,
				line: line
			)
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   - message: Message associated with this error.
///   Default value is "Unimplemented".
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplemented<A1, A2, R>(
	_ message: StaticString = "Unimplemented",
	file: StaticString = #fileID,
	line: UInt = #line
) -> @Sendable (A1, A2) -> R {
	{ _, _ in
		Unimplemented
			.error(
				message: message,
				file: file,
				line: line
			)
			.asFatalError()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented part of code.
/// Throws ``Unimplemented`` when executed.
///
/// - Parameters:
///   - message: Message associated with this error.
///   Default value is "Unimplemented".
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Function throwing ``Unimplemented`` error when executed.
public func unimplementedThrowing<A1, A2, R>(
	_ message: StaticString = "Unimplemented",
	file: StaticString = #fileID,
	line: UInt = #line
) -> @Sendable (A1, A2) throws -> R {
	{ _, _ in
		throw
			Unimplemented
			.error(
				message: message,
				file: file,
				line: line
			)
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   - message: Message associated with this error.
///   Default value is "Unimplemented".
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplemented<A1, A2, A3, R>(
	_ message: StaticString = "Unimplemented",
	file: StaticString = #fileID,
	line: UInt = #line
) -> @Sendable (A1, A2, A3) -> R {
	{ _, _, _ in
		Unimplemented
			.error(
				message: message,
				file: file,
				line: line
			)
			.asFatalError()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented part of code.
/// Throws ``Unimplemented`` when executed.
///
/// - Parameters:
///   - message: Message associated with this error.
///   Default value is "Unimplemented".
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Function throwing ``Unimplemented`` error when executed.
public func unimplementedThrowing<A1, A2, A3, R>(
	_ message: StaticString = "Unimplemented",
	file: StaticString = #fileID,
	line: UInt = #line
) -> @Sendable (A1, A2, A3) throws -> R {
	{ _, _, _ in
		throw
			Unimplemented
			.error(
				message: message,
				file: file,
				line: line
			)
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   - message: Message associated with this error.
///   Default value is "Unimplemented".
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplemented<A1, A2, A3, A4, R>(
	_ message: StaticString = "Unimplemented",
	file: StaticString = #fileID,
	line: UInt = #line
) -> @Sendable (A1, A2, A3, A4) -> R {
	{ _, _, _, _ in
		Unimplemented
			.error(
				message: message,
				file: file,
				line: line
			)
			.asFatalError()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented part of code.
/// Throws ``Unimplemented`` when executed.
///
/// - Parameters:
///   - message: Message associated with this error.
///   Default value is "Unimplemented".
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Function throwing ``Unimplemented`` error when executed.
public func unimplementedThrowing<A1, A2, A3, A4, R>(
	_ message: StaticString = "Unimplemented",
	file: StaticString = #fileID,
	line: UInt = #line
) -> @Sendable (A1, A2, A3, A4) throws -> R {
	{ _, _, _, _ in
		throw
			Unimplemented
			.error(
				message: message,
				file: file,
				line: line
			)
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   - message: Message associated with this error.
///   Default value is "Unimplemented".
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplemented<A1, A2, A3, A4, A5, R>(
	_ message: StaticString = "Unimplemented",
	file: StaticString = #fileID,
	line: UInt = #line
) -> @Sendable (A1, A2, A3, A4, A5) -> R {
	{ _, _, _, _, _ in
		Unimplemented
			.error(
				message: message,
				file: file,
				line: line
			)
			.asFatalError()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented part of code.
/// Throws ``Unimplemented`` when executed.
///
/// - Parameters:
///   - message: Message associated with this error.
///   Default value is "Unimplemented".
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Function throwing ``Unimplemented`` error when executed.
public func unimplementedThrowing<A1, A2, A3, A4, A5, R>(
	_ message: StaticString = "Unimplemented",
	file: StaticString = #fileID,
	line: UInt = #line
) -> @Sendable (A1, A2, A3, A4, A5) throws -> R {
	{ _, _, _, _, _ in
		throw
			Unimplemented
			.error(
				message: message,
				file: file,
				line: line
			)
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   - message: Message associated with this error.
///   Default value is "Unimplemented".
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplemented<A1, A2, A3, A4, A5, A6, R>(
	_ message: StaticString = "Unimplemented",
	file: StaticString = #fileID,
	line: UInt = #line
) -> @Sendable (A1, A2, A3, A4, A5, A6) -> R {
	{ _, _, _, _, _, _ in
		Unimplemented
			.error(
				message: message,
				file: file,
				line: line
			)
			.asFatalError()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented part of code.
/// Throws ``Unimplemented`` when executed.
///
/// - Parameters:
///   - message: Message associated with this error.
///   Default value is "Unimplemented".
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Function throwing ``Unimplemented`` error when executed.
public func unimplementedThrowing<A1, A2, A3, A4, A5, A6, R>(
	_ message: StaticString = "Unimplemented",
	file: StaticString = #fileID,
	line: UInt = #line
) -> @Sendable (A1, A2, A3, A4, A5, A6) throws -> R {
	{ _, _, _, _, _, _ in
		throw
			Unimplemented
			.error(
				message: message,
				file: file,
				line: line
			)
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   - message: Message associated with this error.
///   Default value is "Unimplemented".
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplemented<A1, A2, A3, A4, A5, A6, A7, R>(
	_ message: StaticString = "Unimplemented",
	file: StaticString = #fileID,
	line: UInt = #line
) -> @Sendable (A1, A2, A3, A4, A5, A6, A7) -> R {
	{ _, _, _, _, _, _, _ in
		Unimplemented
			.error(
				message: message,
				file: file,
				line: line
			)
			.asFatalError()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented part of code.
/// Throws ``Unimplemented`` when executed.
///
/// - Parameters:
///   - message: Message associated with this error.
///   Default value is "Unimplemented".
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Function throwing ``Unimplemented`` error when executed.
public func unimplementedThrowing<A1, A2, A3, A4, A5, A6, A7, R>(
	_ message: StaticString = "Unimplemented",
	file: StaticString = #fileID,
	line: UInt = #line
) -> @Sendable (A1, A2, A3, A4, A5, A6, A7) throws -> R {
	{ _, _, _, _, _, _, _ in
		throw
			Unimplemented
			.error(
				message: message,
				file: file,
				line: line
			)
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   - message: Message associated with this error.
///   Default value is "Unimplemented".
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplemented<A1, A2, A3, A4, A5, A6, A7, A8, R>(
	_ message: StaticString = "Unimplemented",
	file: StaticString = #fileID,
	line: UInt = #line
) -> @Sendable (A1, A2, A3, A4, A5, A6, A7, A8) -> R {
	{ _, _, _, _, _, _, _, _ in
		Unimplemented
			.error(
				message: message,
				file: file,
				line: line
			)
			.asFatalError()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented part of code.
/// Throws ``Unimplemented`` when executed.
///
/// - Parameters:
///   - message: Message associated with this error.
///   Default value is "Unimplemented".
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Function throwing ``Unimplemented`` error when executed.
public func unimplementedThrowing<A1, A2, A3, A4, A5, A6, A7, A8, R>(
	_ message: StaticString = "Unimplemented",
	file: StaticString = #fileID,
	line: UInt = #line
) -> @Sendable (A1, A2, A3, A4, A5, A6, A7, A8) throws -> R {
	{ _, _, _, _, _, _, _, _ in
		throw
			Unimplemented
			.error(
				message: message,
				file: file,
				line: line
			)
	}
}
