import Foundation

/// Common protocol for error instances.
///
/// "One Error to rule them all, One Error to handle them, One Error to bring them all, and on the screen bind them."
///
/// ``TheError`` provides additional source code metadata for better diagnostics.
/// It also adds convenient methods for treating errors as fatal and assertion failures.
public protocol TheError: Error, CustomStringConvertible, CustomDebugStringConvertible, DisplayableWithString {

	/// Group assigned to this error type.
	///
	/// Access ``TheErrorGroup`` associated
	/// with this error. It can be used
	/// to quickly identify error domains or
	/// group errors by any other meaning.
	/// Default group for all errors is ``TheErrorGroup.default``.
	/// You can assign any group to an error
	/// by overriding ``TheError.group`` implementation.
	static var group: TheErrorGroup { get }

	/// Source code metadata context for this error.
	/// It is used to derive default implementations
	/// of ``Hashable`` and ``Equatable`` protocols.
	var context: SourceCodeContext { get set }
	/// String representation displayable to the end user.
	///
	/// Used as default value for ``localizedDescription``.
	/// Default implementation fetches message from
	/// ``TheErrorDisplayableMessages``.
	/// It is used to derive default implementations
	/// of ``Hashable`` and ``Equatable`` protocols.
	var displayableString: DisplayableString { get }
	/// ``merge`` adds contents of provided error to this error.
	///
	/// When merging, composite should take all informations
	/// that it can handle and update self with new data.
	/// It is intended to change or add error details
	/// when i.e. catching other error while trying to keep
	/// diagnostics data in place.
	///
	/// - Parameter other: Other error to be merged into this one.
	mutating func merge(
		with other: TheError,
		file: StaticString,
		line: UInt
	)
	/// Function checking equality of errors.
	///
	/// This function can be used to check if two errors
	/// are equal. Default implementation verifies only
	/// displayable messages of errors. You can override
	/// it to prepare more accurate equality check for
	/// custom error types. Simplest implementation is to
	/// cast argument value to Self type and check required
	/// properties equality.
	///
	/// - Parameter other: Other error to verify equality.
	/// - Returns: `true` if errors are equal or `false` otherwise.
	func isEqual(
		to other: Error
	) -> Bool
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension TheError /* CustomStringConvertible */ {

	public var description: String {
		"""
		⎡\(Self.self)
		⎜\(self.context.description.replacingOccurrences(of: "\n", with: "\n⎜"))
		⎣\(Self.self)
		"""
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension TheError /* CustomDebugStringConvertible */ {

	public var debugDescription: String {
		let propertiesDescription: String = self.propertiesPrettyDescription
		let propertiesDescriptionEmpty: Bool = propertiesDescription.isEmpty

		return """

		⎡ ⚠️ \(Self.self)
		⎜ 📺 \(self.displayableStringPrettyDescription)\(propertiesDescriptionEmpty ? "" : "\n⎜ 📦 Properties: \(propertiesDescription)")
		⎜ 🧵 Context: \(self.context.prettyDescription)
		⎣ ⚠️ \(Self.self)
		"""
	}

	private var displayableStringPrettyDescription: String {
		self.displayableString
			.resolved
			.replacingOccurrences(  // keep indentation
				of: "\n",
				with: "\n⎜ ⮑ "
			)
	}

	private var propertiesPrettyDescription: String {
		Mirror(reflecting: self)
			.children  // ignoring "displayStyle"
			.reduce(into: String()) { result, child in
				let formattedLabel: String
				if let label: String = child.label {
					// `context` is part of debug description anyway
					// `displayableString` has own section in description
					guard label != "context", label != "displayableString"
					else { return }  // skip property
					formattedLabel = "\n⎜ 📎 \(label): "
				}
				else {
					formattedLabel = "\n⎜ 📎 "
				}

				let formattedValue: String =
					.init(
						reflecting: child.value
					)
					.replacingOccurrences(  // keep indentation
						of: "\n",
						with: "\n⎜ ⮑ "
					)

				result
					.append("\(formattedLabel)\(formattedValue)")
			}
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension TheError /* DisplayableWithString */ {

	public var displayableString: DisplayableString {
		TheErrorDisplayableMessages.message(for: Self.self)
	}
}

extension TheError {

	/// ``merge`` adds contents of provided error to this error.
	///
	/// When merging, composite should take all informations
	/// that it can handle and update self with new data.
	/// It is intended to change or add error details
	/// when i.e. catching other error while trying to keep
	/// diagnostics data in place.
	///
	/// - Parameters:
	///   - other: Other error to be merged into this one.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	public mutating func merge(
		with other: TheError,
		file: StaticString = #fileID,
		line: UInt = #line
	) {
		self.context = .merging(self.context, other.context)
	}

	/// ``merging`` adds contents of provided error to this error copy.
	///
	/// When merging, composite should take all informations
	/// that it can handle and update self with new data.
	/// It is intended to change or add error deatails
	/// when i.e. catching other error while trying to keep
	/// diagnostics data in place.
	///
	/// - Parameters:
	///   - other: Other error to be merged into this error copy.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: Copy of this error with error merged.
	public func merging(
		with other: TheError,
		file: StaticString = #fileID,
		line: UInt = #line
	) -> TheError {
		var copy: Self = self
		copy.merge(
			with: other,
			file: file,
			line: line
		)
		return copy
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension TheError {

	public static var group: TheErrorGroup {
		.default
	}

	public var localizedDescription: String {
		self.displayableString.resolved
	}

	public func isEqual(
		to other: Error
	) -> Bool {
		if let typed: Self = other as? Self {
			return self.displayableString == typed.displayableString
		}
		else {
			return false
		}
	}
}

extension TheError {

	/// Unique id of this error type.
	///
	/// Access ``TheErrorID`` associated
	/// with this error. It can be used
	/// to quickly identify errors or store it
	/// in collections requiring ``Hashable`` conformance.
	/// It is used to derive default implementations
	/// of ``Hashable`` and ``Equatable`` protocols.
	public static var id: TheErrorID {
		.init(Self.self)
	}

	/// Group assigned to this error.
	///
	/// Access ``TheErrorGroup`` associated
	/// with this error. It can be used
	/// to quickly identify error domains or
	/// group errors by any other meaning.
	public var group: TheErrorGroup { Self.group }

	/// Terminate process with this error as the cause.
	///
	/// - Parameters:
	///   - message: Optional, additional message associated with process termination.
	///   Default is empty.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	@_transparent
	@Sendable public func asFatalError(
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
	/// It has no effect on release builds.
	///
	/// - Parameters:
	///   - message: Optional, additional message associated with process termination.
	///   Default is empty.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: The same error instance.
	@discardableResult @_transparent
	@Sendable public func asAssertionFailure(
		message: @autoclosure () -> String = .init(),
		file: StaticString = #fileID,
		line: UInt = #line
	) -> Self {
		#if DEBUG
		runtimeAssertionFailure(
			message: "\(message())\n\(self.debugDescription)",
			file: file,
			line: line
		)
		#endif
		return self
	}

	/// Treat this error as a breakpoint in debug builds.
	///
	/// Trigger a breakpoint with this error as a cause.
	/// It has no effect on release builds and debug builds without debugger attached.
	///
	/// - Parameters:
	///   - message: Optional, additional message associated with breakpoint message.
	///   Default is empty.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: The same error instance.
	@discardableResult @_transparent
	@Sendable public func asBreakpoint(
		message: @autoclosure () -> String = .init(),
		file: StaticString = #fileID,
		line: UInt = #line
	) -> Self {
		#if DEBUG
		breakpoint(
			"\(file):\(line) \(message())\n\(self.debugDescription)"
		)
		#endif
		return self
	}

	/// Treat this error as a runtime warning in debug builds.
	///
	/// Show a runtime warning with this error as a cause.
	/// It has no effect on release builds.
	///
	/// - Parameters:
	///   - message: Optional, additional message associated with runtime warning message.
	///   Default is empty.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: The same error instance.
	@discardableResult @_transparent
	@Sendable public func asRuntimeWarning(
		message: @autoclosure () -> StaticString = .init(),
		file: StaticString = #fileID,
		line: UInt = #line
	) -> Self {
		#if DEBUG
		runtimeWarning(
			"%s\n%s\n%s",
			[
				String(describing: Self.self),
				message().asString,
				self.context
					.debugDescription,
			]
		)
		#endif
		return self
	}

	/// Log this error using ``OSDiagnostics.shared``.
	///
	/// Log this error using default logger
	/// which is ``OSDiagnostics.shared`` instance.
	///
	/// - Returns: The same error instance.
	@discardableResult @_transparent
	@Sendable public func log() -> Self {
		OSDiagnostics.shared.log(self)
		return self
	}

	/// Append additional ``SourceCodeMeta`` to this error ``context``.
	///
	/// Appending ``SourceCodeMeta`` allows making diagnostics stack similar to stack traces.
	/// However it is selected by programmer what points in source code will be included.
	///
	/// - Parameter context: ``SourceCodeMeta`` to be appended.
	@inlinable @inline(__always)
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
	@inlinable @inline(__always)
	@Sendable public func appending(
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
	@_transparent
	public mutating func set<Value>(
		_ value: @autoclosure () -> Value,
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
	@_transparent
	@Sendable public func with<Value>(
		_ value: @autoclosure () -> Value,
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
