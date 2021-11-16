/// Common protocol for error instances.
///
/// "One Error to rule them all, One Error to handle them, One Error to bring them all, and on the screen bind them."
///
/// ``TheError`` provides additional source code metadata for better diagnostics.
/// It also adds convenient methods for treating errors as fatal and assertion failures.
public protocol TheError: Error, CustomDebugStringConvertible {

	/// Source code metadata context for this error.
	var context: SourceCodeContext { get set }
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension TheError /* CustomDebugStringConvertible */ {

	public var debugDescription: String {
		"\(Self.self)\n\(self.context.debugDescription)"
	}
}

extension TheError {

	/// Terminate process with this error as the cause.
	///
	/// - Parameters:
	///   - message: Optional, additional message associated with process termination.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	public func asFatalError(
		message: String? = .none,
		file: StaticString = #fileID,
		line: UInt = #line
	) -> Never {
		fatalError(
			"\(message.map { "\($0)\n" } ?? "\n")\(self.debugDescription)",
			file: file,
			line: line
		)
	}

	/// Treat this error as the cause of assertion failure.
	///
	/// Assertion failure will be executed by using ``runtimeAssertionFailure`` method.
	/// Its actual result depends on current ``runtimeAssertionMethod`` implementation.
	/// Default behaviour will result in crash in debug builds and have no effect on release builds.
	///
	/// - Parameters:
	///   - message: Optional, additional message associated with process termination.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	public func asAssertionFailure(
		message: String? = .none,
		file: StaticString = #fileID,
		line: UInt = #line
	) {
		runtimeAssertionFailure(
			message: "\(message.map { "\($0)\n" } ?? "\n")\(self.debugDescription)",
			file: file,
			line: line
		)
	}

	/// Append additional ``SourceCodeMeta`` to this error ``context``.
	///
	/// Appending ``SourceCodeMeta`` allows making diagnostics stack similar to stack traces.
	/// However it is selected by programmer what points in source code will be included.
	///
	/// - Parameter context: ``SourceCodeMeta`` to be appended.
	public mutating func append(
		_ context: SourceCodeMeta
	) {
		self.context.append(context)
	}

	/// Make a copy of this error and append additional ``SourceCodeMeta`` to its ``context``.
	///
	/// Appending ``SourceCodeMeta`` allows making diagnostics stack similar to stack traces.
	/// However it is selected by programmer what points in source code will be included.
	///
	/// - Parameter context: ``SourceCodeMeta`` to be appended.
	/// - Returns: Copy of this error with additional ``SourceCodeMeta`` appended to its ``context``.
	public func appending(
		_ context: SourceCodeMeta
	) -> Self {
		var copy: Self = self
		copy.append(context)
		return copy
	}
}
