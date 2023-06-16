/// ``TheError`` for unimplemented features.
///
/// ``Unimplemented`` error can occur when some feature is not implemented.
public struct Unimplemented: TheError {

	/// Create instance of ``Unimplemented`` error.
	///
	/// - Parameters:
	///   - message: Message associated with this error.
	///   Default value is based on ``TheErrorDisplayableMessages``.
	///   - group: ``TheErrorGroup`` associated with this error instance.
	///   Default value is ``TheErrorGroup.default``.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: New instance of ``Unimplemented`` error with given context.
	public static func error(
		message: StaticString = "Unimplemented",
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

/// Convenient placeholder for unimplemented part of code.
///
/// Placeholder for indicating unimplemented part of code.
/// Terminates process with ``Unimplemented`` error as the cause.
///
/// - Parameters:
///   - message: Message associated with this error.
///   Default value is "Unimplemented".
///   - group: ``TheErrorGroup`` associated with this error instance.
///   Default value is ``TheErrorGroup.default``.
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Never, function terminates the process.
public func unimplemented(
	_ message: StaticString = "Unimplemented",
	group: TheErrorGroup = .default,
	file: StaticString = #fileID,
	line: UInt = #line
) -> Never {
	Unimplemented
		.error(
			message: message,
			group: group,
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
///   - group: ``TheErrorGroup`` associated with this error instance.
///   Default value is ``TheErrorGroup.default``.
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplemented0<R>(
	_ message: StaticString = "Unimplemented",
	group: TheErrorGroup = .default,
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
///   - group: ``TheErrorGroup`` associated with this error instance.
///   Default value is ``TheErrorGroup.default``.
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Function throwing ``Unimplemented`` error when executed.
public func unimplemented0Throwing<R>(
	_ message: StaticString = "Unimplemented",
	group: TheErrorGroup = .default,
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
///   - group: ``TheErrorGroup`` associated with this error instance.
///   Default value is ``TheErrorGroup.default``.
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplemented1<A1, R>(
	_ message: StaticString = "Unimplemented",
	group: TheErrorGroup = .default,
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
///   - group: ``TheErrorGroup`` associated with this error instance.
///   Default value is ``TheErrorGroup.default``.
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Function throwing ``Unimplemented`` error when executed.
public func unimplemented1Throwing<A1, R>(
	_ message: StaticString = "Unimplemented",
	group: TheErrorGroup = .default,
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
///   - group: ``TheErrorGroup`` associated with this error instance.
///   Default value is ``TheErrorGroup.default``.
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplemented2<A1, A2, R>(
	_ message: StaticString = "Unimplemented",
	group: TheErrorGroup = .default,
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
///   - group: ``TheErrorGroup`` associated with this error instance.
///   Default value is ``TheErrorGroup.default``.   
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Function throwing ``Unimplemented`` error when executed.
public func unimplemented2Throwing<A1, A2, R>(
	_ message: StaticString = "Unimplemented",
	group: TheErrorGroup = .default,
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
///   - group: ``TheErrorGroup`` associated with this error instance.
///   Default value is ``TheErrorGroup.default``.
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplemented3<A1, A2, A3, R>(
	_ message: StaticString = "Unimplemented",
	group: TheErrorGroup = .default,
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
///   - group: ``TheErrorGroup`` associated with this error instance.
///   Default value is ``TheErrorGroup.default``.
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Function throwing ``Unimplemented`` error when executed.
public func unimplemented3Throwing<A1, A2, A3, R>(
	_ message: StaticString = "Unimplemented",
	group: TheErrorGroup = .default,
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
///   - group: ``TheErrorGroup`` associated with this error instance.
///   Default value is ``TheErrorGroup.default``.
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplemented4<A1, A2, A3, A4, R>(
	_ message: StaticString = "Unimplemented",
	group: TheErrorGroup = .default,
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
///   - group: ``TheErrorGroup`` associated with this error instance.
///   Default value is ``TheErrorGroup.default``.
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Function throwing ``Unimplemented`` error when executed.
public func unimplemented4Throwing<A1, A2, A3, A4, R>(
	_ message: StaticString = "Unimplemented",
	group: TheErrorGroup = .default,
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
///   - group: ``TheErrorGroup`` associated with this error instance.
///   Default value is ``TheErrorGroup.default``.
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplemented5<A1, A2, A3, A4, A5, R>(
	_ message: StaticString = "Unimplemented",
	group: TheErrorGroup = .default,
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
///   - group: ``TheErrorGroup`` associated with this error instance.
///   Default value is ``TheErrorGroup.default``.
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Function throwing ``Unimplemented`` error when executed.
public func unimplemented5Throwing<A1, A2, A3, A4, A5, R>(
	_ message: StaticString = "Unimplemented",
	group: TheErrorGroup = .default,
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
///   - group: ``TheErrorGroup`` associated with this error instance.
///   Default value is ``TheErrorGroup.default``.
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplemented6<A1, A2, A3, A4, A5, A6, R>(
	_ message: StaticString = "Unimplemented",
	group: TheErrorGroup = .default,
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
///   - group: ``TheErrorGroup`` associated with this error instance.
///   Default value is ``TheErrorGroup.default``.
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Function throwing ``Unimplemented`` error when executed.
public func unimplemented6Throwing<A1, A2, A3, A4, A5, A6, R>(
	_ message: StaticString = "Unimplemented",
	group: TheErrorGroup = .default,
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
///   - group: ``TheErrorGroup`` associated with this error instance.
///   Default value is ``TheErrorGroup.default``.
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplemented7<A1, A2, A3, A4, A5, A6, A7, R>(
	_ message: StaticString = "Unimplemented",
	group: TheErrorGroup = .default,
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
///   - group: ``TheErrorGroup`` associated with this error instance.
///   Default value is ``TheErrorGroup.default``.
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Function throwing ``Unimplemented`` error when executed.
public func unimplemented7Throwing<A1, A2, A3, A4, A5, A6, A7, R>(
	_ message: StaticString = "Unimplemented",
	group: TheErrorGroup = .default,
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
///   - group: ``TheErrorGroup`` associated with this error instance.
///   Default value is ``TheErrorGroup.default``.
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplemented8<A1, A2, A3, A4, A5, A6, A7, A8, R>(
	_ message: StaticString = "Unimplemented",
	group: TheErrorGroup = .default,
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
///   - group: ``TheErrorGroup`` associated with this error instance.
///   Default value is ``TheErrorGroup.default``.   
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
/// - Returns: Function throwing ``Unimplemented`` error when executed.
public func unimplemented8Throwing<A1, A2, A3, A4, A5, A6, A7, A8, R>(
	_ message: StaticString = "Unimplemented",
	group: TheErrorGroup = .default,
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
