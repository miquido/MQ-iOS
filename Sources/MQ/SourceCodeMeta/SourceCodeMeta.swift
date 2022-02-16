/// Source code metadata conected with a location in source code.
///
/// ``SourceCodeMeta`` should be always avoided in application logic.
/// Collected data should be used only for diagnostics purposes.
///
/// - warning: ``SourceCodeMeta`` is not intended to provide any data across application.
public struct SourceCodeMeta {

	/// Create ``SourceCodeMeta`` for further diagnostics using given source code location.
	///
	/// Default location provided is this function call location.
	/// `file` and `line` arguments should not be provided manually unless it is required.
	///
	///- Parameters:
	///   - message: Message associated with given source code location.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: Instance of ``SourceCodeMeta`` for given context.
	public static func context(
		message: StaticString,
		file: StaticString = #fileID,
		line: UInt = #line
	) -> Self {
		Self(
			message: message,
			sourceCodeLocation: .here(
				file: file,
				line: line
			)
		)
	}

	private let message: StaticString
	private let sourceCodeLocation: SourceCodeLocation
	#if DEBUG
		private var values: Dictionary<StaticString, Any> = .init()
	#endif

	/// Associate any dynamic value with given key for this ``SourceCodeMeta``.
	///
	/// This method can be used to provide additional diagnostics.
	/// It does nothing in release builds.
	///
	/// - Parameters:
	///   - value: Any value to be associated with given key.
	///   Replaces previous value for the same key if any.
	///   - Parameter key: Key used to identify provided value.
	public mutating func set(
		_ value: @autoclosure () -> Any,
		for key: StaticString
	) {
		#if DEBUG
			self.values[key] = value()
		#endif
	}

	/// Make a copy of this ``SourceCodeMeta`` and associate any dynamic value with given key with it.
	///
	/// This method can be used to provide additional diagnostics.
	/// It does nothing in release builds.
	///
	/// - Parameters:
	///   - value: Any value to associated with given key.
	///   Replaces previous value for the same key if any.
	///   - key: Key used to identify provided value.
	/// - Returns: Copy of this ``SourceCodeMeta`` with additional associated value.
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

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension SourceCodeMeta: CustomStringConvertible {

	public var description: String {
		var description: String = "\(self.sourceCodeLocation.description)"

		if !self.message.isEmpty {
			description.append("\n \" \(self.message.asString) ")
		}
		else {
			noop()
		}

		return description
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension SourceCodeMeta: CustomDebugStringConvertible {

	public var debugDescription: String {
		#if DEBUG
			self.description
				.appending(
					self.values
						.reduce(
							into: String(),
							{ (result, value) in
								result.append("\n - \(value.key): \(value.value)")
							}
						)
				)
		#else
			self.description
		#endif
	}
}
