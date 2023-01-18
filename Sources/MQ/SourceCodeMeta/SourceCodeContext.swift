/// Source code metadata that can be collected across the application.
///
/// ``SourceCodeContext`` can be used to provide additional metadata for extended application diagnostics.
/// It allows making diagnostics stack similar to stack traces.
/// However it is selected by programmer what informations are included.
/// Debug builds are allowed to collect additional dynamic values for more precise tracking and details.
/// Dynamic values are striped out in release builds to prevent potential security issues.
/// Only static metadata is collected in release builds.
///
/// ``SourceCodeContext`` consists of stack of ``SourceCodeMeta``
/// pointing to the concrete source code locations.
/// Locations and dynamic values can be appended when passing
/// ``SourceCodeContext`` through method calls in order to add more detailed context.
///
/// ``SourceCodeContext`` should be avoided in application logic.
/// Collected data is intended to be used
/// for diagnostics purposes.
public struct SourceCodeContext: Sendable {

	/// Create ``SourceCodeMeta`` using given source code location and message.
	///
	/// - Parameters:
	///   - message: Message associated with given source code location.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: Instance of ``SourceCodeContext`` for given message and location.
	public static func context(
		message: StaticString,
		file: StaticString = #fileID,
		line: UInt = #line
	) -> Self {
		Self(
			contextStack: [
				.message(
					message,
					file: file,
					line: line
				)
			]
		)
	}

	private var contextStack: Array<SourceCodeMeta>

	/// Append additional ``SourceCodeMeta`` to this ``SourceCodeContext``.
	///
	/// Appending ``SourceCodeMeta`` allows making diagnostics stack similar to stack traces.
	/// However it is selected by programmer what points in source code will be included.
	///
	/// - Parameter meta: ``SourceCodeMeta`` to be appended.
	public mutating func append(
		_ meta: SourceCodeMeta
	) {
		self.contextStack.append(meta)
	}

	/// Make a copy of this ``SourceCodeContext`` and append additional ``SourceCodeMeta`` to it.
	///
	/// Appending ``SourceCodeMeta`` allows making diagnostics stack similar to stack traces.
	/// However it is selected by programmer what points in source code will be included.
	///
	/// - Parameter meta: ``SourceCodeMeta`` to be appended.
	/// - Returns: Copy of this ``SourceCodeContext`` with additional ``SourceCodeMeta`` appended.
	public func appending(
		_ meta: SourceCodeMeta
	) -> Self {
		var copy: Self = self
		copy.append(meta)
		return copy
	}

	/// Associate any dynamic value with given key for the last ``SourceCodeMeta`` in this ``SourceCodeContext``.
	///
	/// This method can be used to provide additional diagnostics.
	/// It does nothing in release builds.
	///
	/// - Parameters:
	///   - value: Any value to be associated with given key with the last ``SourceCodeMeta`` in this ``SourceCodeContext``.
	///   Replaces previous value for the same key if it already exists in last ``SourceCodeMeta``.
	///   - key: Key used to identify provided value.
	public mutating func set<Value>(
		_ value: @autoclosure () -> Value,
		for key: StaticString
	) {
		#if DEBUG
			guard let lastIndex: Array<SourceCodeMeta>.Index = self.contextStack.lastIndex(where: { _ in true })
			else { return }
			self.contextStack[lastIndex].set(value(), for: key)
		#endif
	}

	/// Make a copy of this ``SourceCodeContext`` and associate any dynamic value with given key for the last ``SourceCodeMeta`` in this ``SourceCodeContext``.
	///
	/// This method can be used to provide additional diagnostics.
	/// It does nothing in release builds.
	///
	/// - Parameters:
	///   - value: Any value to be associated with given key with the last ``SourceCodeMeta`` in this ``SourceCodeContext`` copy.
	///   Replaces previous value for the same key if it already exists in last ``SourceCodeMeta``.
	///   - key: Key used to identify provided value.
	/// - Returns: Copy of this ``SourceCodeContext`` with additional value associated with last ``SourceCodeMeta`` in the copy.
	public func with<Value>(
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

	/// Merge multiple contexts in provided order.
	///
	/// Merging contexts allow flattening information from multiple sources
	/// into single instance. It can be useful when providing error wrappers
	/// which can append own context metadata to wrapped error while keeping
	/// all context data flat in single place.
	///
	/// Last context content will be placed last on stack
	/// and its last meta will become current last.
	///
	/// - Parameters:
	///   - head: First context to merge.
	///   - mid: Second context to merge.
	///   - tail: Any number of next contexts to merge in provided order.
	/// - Returns: New instance of ``SourceCodeContext`` with
	/// merged context stacks according to provided order.
	public static func merging(
		_ head: SourceCodeContext,
		_ mid: SourceCodeContext,
		_ tail: SourceCodeContext...
	) -> Self {
		.merging([head, mid] + tail)
	}

	/// Merge multiple contexts in provided order.
	///
	/// Merging contexts allow flattening information from multiple sources
	/// into single instance. It can be useful when providing error wrappers
	/// which can append own context metadata to wrapped error while keeping
	/// all context data flat in single place.
	///
	/// Last context content will be placed last on stack
	/// and its last meta will become current last.
	///
	/// - Parameter contexts: Any number of next contexts to merge in provided order.
	/// - Returns: New instance of ``SourceCodeContext`` with
	/// merged context stacks according to provided order.
	public static func merging(
		_ contexts: Array<SourceCodeContext>
	) -> Self {
		Self(
			contextStack:
				contexts
				.reduce(
					into: .init(),
					{ (result: inout Array<SourceCodeMeta>, context: SourceCodeContext) in
						result.append(contentsOf: context.contextStack)
					}
				)
		)
	}
}

extension SourceCodeContext: Hashable {}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension SourceCodeContext: CustomStringConvertible {

	public var description: String {
		self.contextStack
			.reduce(
				into: "---",
				{ (result: inout String, meta: SourceCodeMeta) in
					result.append("\n•\(meta.description)")
				}
			)
			.appending("\n---")
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension SourceCodeContext: CustomDebugStringConvertible {

	public var debugDescription: String {
		self.contextStack
			.reduce(
				into: "---",
				{ (result: inout String, meta: SourceCodeMeta) in
					result.append("\n•\(meta.debugDescription)")
				}
			)
			.appending("\n---")
	}

	internal var prettyDescription: String {
		self.contextStack
			.reduce(
				into: "",
				{ (result: inout String, meta: SourceCodeMeta) in
					result.append("\n⎜\(meta.prettyDescription)")
				}
			)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension SourceCodeContext: CustomLeafReflectable {

	public var customMirror: Mirror {
		.init(
			self,
			children: [
				"contextStack": self.contextStack
			],
			displayStyle: .struct
		)
	}
}
