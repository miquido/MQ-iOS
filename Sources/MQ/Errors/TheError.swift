/// Common protocol for error instances.
///
/// "One Error to rule them all, One Error to handle them, One Error to bring them all, and on the screen bind them."
///
/// ``TheError`` provides additional source code metadata for better diagnostics.
/// It also adds convenient methods for treating errors as fatal and assertion failures.
public protocol TheError: Error, CustomDebugStringConvertible {

	/// Source code metadata context for this error.
	var context: SourceCodeContext { get set }
	/// String representation displayable to the end user.
	///
	/// Used as default value for ``localizedDescription``.
	/// Implemented as error type name by default.
	var displayableMessage: DisplayableString { get }
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension TheError /* CustomDebugStringConvertible */ {

	public var debugDescription: String {
		"\(Self.self)\n\(self.context.debugDescription)"
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension TheError {

	public var displayableMessage: DisplayableString {
		"\(Self.self)"
	}

	public var localizedDescription: String {
		self.displayableMessage.string
	}
}

extension TheError {

	/// Terminate process with this error as the cause.
	///
	/// - Parameters:
	///   - message: Optional, additional message associated with process termination.
	///   Default is empty.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	public func asFatalError(
		message: @autoclosure () -> String = .init(),
		file: StaticString = #fileID,
		line: UInt = #line
	) -> Never {
		fatalError(
			"\(message())\n\(self.debugDescription)",
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
	///   Default is empty.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	public func asAssertionFailure(
		message: @autoclosure () -> String = .init(),
		file: StaticString = #fileID,
		line: UInt = #line
	) {
		runtimeAssertionFailure(
			message: "\(message())\n\(self.debugDescription)",
			file: file,
			line: line
		)
	}

	/// Treat this error as a breakpoint in debug builds.
	///
	/// Trigger a breakpoint with this errror as a cause.
	/// It has no effect on release builds and debug builds without debugger attached.
	///
	/// - Parameters:
	///   - message: Optional, additional message associated with breakpoint message.
	///   Default is empty.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	public func asBreakpoint(
		message: @autoclosure () -> String = .init(),
		file: StaticString = #fileID,
		line: UInt = #line
	) {
		breakpoint(
			"\(file):\(line) \(message())\n\(self.debugDescription)"
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

	/// Associate any dynamic value with given key for the last ``SourceCodeMeta``
	/// in ``SourceCodeContext`` of this error.
	///
	/// This method can be used to provide additional diagnostics.
	/// It does nothing in release builds.
	///
	/// - Parameters:
	///   - value: Any value to be associated with given key with the last ``SourceCodeMeta``
	///   in ``SourceCodeContext`` of this error.
	///   Replaces previous value for the same key if it already exists in last ``SourceCodeMeta``.
	///   - key: Key used to identify provided value.
	public mutating func set(
		_ value: @autoclosure () -> Any,
		for key: StaticString
	) {
		#if DEBUG
			self.context.set(value(), for: key)
		#endif
	}

	/// Make a copy of this error and associate any dynamic value with given key
	/// for the last ``SourceCodeMeta`` in ``SourceCodeContext`` of this error copy.
	///
	/// This method can be used to provide additional diagnostics.
	/// It does nothing in release builds.
	///
	/// - Parameters:
	///   - value: Any value to be associated with given key with the last ``SourceCodeMeta``
	///   in ``SourceCodeContext`` of this error copy.
	///   Replaces previous value for the same key if it already exists in last ``SourceCodeMeta``.
	///   - key: Key used to identify provided value.
	/// - Returns: Copy of this error with additional value associated with last
	///  ``SourceCodeMeta`` in the copy.
	public func with(
		_ value: @autoclosure () -> Any,
		for key: StaticString
	) -> Self {
		#if DEBUG
			var copy: Self = self
			copy.set(value(), for: key)
			return copy
		#else
			return self
		#endif
	}
}
