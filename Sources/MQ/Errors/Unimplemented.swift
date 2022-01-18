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

/// Convenient placeholder for unimplemented part of code.
///
/// Placeholder for indicating unimplemented async part of code.
/// Terminates process with ``Unimplemented`` error as the cause.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Never, function terminates the process.
public func unimplementedAsync() -> Never {
	Unimplemented
		.error()
		.asFatalError()
}

/// Convenient placeholder for unimplemented part of code.
///
/// Placeholder for indicating unimplemented throwing part of code.
/// Terminates process with ``Unimplemented`` error as the cause.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Throws: Unimplemented error.
/// - Returns: Unimplemented error as result.
public func unimplementedThrowing() throws -> Error {
	throw Unimplemented.error()
}

/// Convenient placeholder for unimplemented part of code.
///
/// Placeholder for indicating unimplemented async throwing part of code.
/// Terminates process with ``Unimplemented`` error as the cause.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Throws: Unimplemented error.
/// - Returns: Unimplemented error as a result.
public func unimplementedAsyncThrowing() async throws -> Error {
	throw Unimplemented.error()
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
) -> () -> R {
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
/// Placeholder for a function indicating unimplemented async part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedAsync<R>() -> () async -> R {
	{
		Unimplemented
			.error()
			.asFatalError()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented throwing part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedThrow<R>() -> () throws -> R {
	{
		throw Unimplemented.error()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented async throwing part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedAsyncThrow<R>() -> () async throws -> R {
	{
		throw Unimplemented.error()
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
) -> (A1) -> R {
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
/// Placeholder for a function indicating unimplemented async part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedAsync<A1, R>() -> (A1) async -> R {
	{ _ in
		Unimplemented
			.error()
			.asFatalError()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented throwing part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedThrowing<A1, R>() -> (A1) throws -> R {
	{ _ in
		throw Unimplemented.error()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented async throwing part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedThrowing<A1, R>() -> (A1) async throws -> R {
	{ _ in
		throw Unimplemented.error()
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
) -> (A1, A2) -> R {
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
/// Placeholder for a function indicating unimplemented async part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedAsync<A1, A2, R>() -> (A1, A2) async -> R {
	{ _, _ in
		Unimplemented
			.error()
			.asFatalError()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented throwing part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedThrowing<A1, A2, R>() -> (A1, A2) throws -> R {
	{ _, _ in
		throw Unimplemented.error()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented async throwing part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedThrowing<A1, A2, R>() -> (A1, A2) async throws -> R {
	{ _, _ in
		throw Unimplemented.error()
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
) -> (A1, A2, A3) -> R {
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
/// Placeholder for a function indicating unimplemented async part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedAsync<A1, A2, A3, R>() -> (A1, A2, A3) async -> R {
	{ _, _, _ in
		Unimplemented
			.error()
			.asFatalError()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented throwing part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedThrowing<A1, A2, A3, R>() -> (A1, A2, A3) throws -> R {
	{ _, _, _ in
		throw Unimplemented.error()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented async throwing part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedAsyncThrowing<A1, A2, A3, R>() -> (A1, A2, A3) async throws -> R {
	{ _, _, _ in
		throw Unimplemented.error()
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
) -> (A1, A2, A3, A4) -> R {
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
/// Placeholder for a function indicating unimplemented async part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedAsync<A1, A2, A3, A4, R>() -> (A1, A2, A3, A4) async -> R {
	{ _, _, _, _ in
		Unimplemented
			.error()
			.asFatalError()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented throwing part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedThrowing<A1, A2, A3, A4, R>() -> (A1, A2, A3, A4) throws -> R {
	{ _, _, _, _ in
		throw Unimplemented.error()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented async throwing part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedAsyncThrowing<A1, A2, A3, A4, R>() -> (A1, A2, A3, A4) async throws -> R {
	{ _, _, _, _ in
		throw Unimplemented.error()
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
) -> (A1, A2, A3, A4, A5) -> R {
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
/// Placeholder for a function indicating unimplemented async part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedAsync<A1, A2, A3, A4, A5, R>() -> (A1, A2, A3, A4, A5) async -> R {
	{ _, _, _, _, _ in
		Unimplemented
			.error()
			.asFatalError()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented throwing part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedThrowing<A1, A2, A3, A4, A5, R>() -> (A1, A2, A3, A4, A5) throws -> R {
	{ _, _, _, _, _ in
		throw Unimplemented.error()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented async throwing part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedAsyncThrowing<A1, A2, A3, A4, A5, R>() -> (A1, A2, A3, A4, A5) async throws -> R {
	{ _, _, _, _, _ in
		throw Unimplemented.error()
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
) -> (A1, A2, A3, A4, A5, A6) -> R {
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
/// Placeholder for a function indicating unimplemented async part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedAsync<A1, A2, A3, A4, A5, A6, R>() -> (A1, A2, A3, A4, A5, A6) async -> R {
	{ _, _, _, _, _, _ in
		Unimplemented
			.error()
			.asFatalError()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented throwing part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedThrowing<A1, A2, A3, A4, A5, A6, R>() -> (A1, A2, A3, A4, A5, A6) throws -> R {
	{ _, _, _, _, _, _ in
		throw Unimplemented.error()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented async throwing part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedAsyncThrowing<A1, A2, A3, A4, A5, A6, R>() -> (A1, A2, A3, A4, A5, A6) async throws -> R {
	{ _, _, _, _, _, _ in
		throw Unimplemented.error()
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
) -> (A1, A2, A3, A4, A5, A6, A7) -> R {
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
/// Placeholder for a function indicating unimplemented async part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedAsync<A1, A2, A3, A4, A5, A6, A7, R>() -> (A1, A2, A3, A4, A5, A6, A7) async -> R {
	{ _, _, _, _, _, _, _ in
		Unimplemented
			.error()
			.asFatalError()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented throwing part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedThrowing<A1, A2, A3, A4, A5, A6, A7, R>() -> (A1, A2, A3, A4, A5, A6, A7) throws -> R {
	{ _, _, _, _, _, _, _ in
		throw Unimplemented.error()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented async throwing part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedAsyncThrowing<A1, A2, A3, A4, A5, A6, A7, R>() -> (A1, A2, A3, A4, A5, A6, A7) async throws ->
	R
{
	{ _, _, _, _, _, _, _ in
		throw Unimplemented.error()
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
) -> (A1, A2, A3, A4, A5, A6, A7, A8) -> R {
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
/// Placeholder for a function indicating unimplemented async part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedAsync<A1, A2, A3, A4, A5, A6, A7, A8, R>() -> (A1, A2, A3, A4, A5, A6, A7, A8) async -> R {
	{ _, _, _, _, _, _, _, _ in
		Unimplemented
			.error()
			.asFatalError()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented throwing part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedThrowing<A1, A2, A3, A4, A5, A6, A7, A8, R>() -> (A1, A2, A3, A4, A5, A6, A7, A8) throws -> R {
	{ _, _, _, _, _, _, _, _ in
		throw Unimplemented.error()
	}
}

/// Convenient placeholder for unimplemented function.
///
/// Placeholder for a function indicating unimplemented async throwing part of code.
/// Terminates process with ``Unimplemented`` error as the cause when the function becomes executed.
///
/// - Parameters:
///   Filled automatically based on compile time constants.
/// - Returns: Placeholder function which terminates the process with ``Unimplemented`` error when executed.
public func unimplementedAsyncThrowing<A1, A2, A3, A4, A5, A6, A7, A8, R>() -> (A1, A2, A3, A4, A5, A6, A7, A8) async
	throws -> R
{
	{ _, _, _, _, _, _, _, _ in
		throw Unimplemented.error()
	}
}
