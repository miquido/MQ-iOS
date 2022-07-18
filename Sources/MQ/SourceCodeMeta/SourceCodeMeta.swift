/// Source code metadata conected with a location in source code.
///
/// ``SourceCodeMeta`` should be always avoided in application logic.
/// Collected data should be used only for diagnostics purposes.
///
/// - warning: ``SourceCodeMeta`` is not intended to provide any data across application.
public struct SourceCodeMeta: Sendable {

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
	/// - Returns: Instance of ``SourceCodeMeta`` for given message.
	public static func message(
		_ message: StaticString,
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
		private let debugValues: CriticalSection<Dictionary<StaticString, Any>> = .init(.init())
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
	public mutating func set<Value>(
		_ value: @autoclosure () -> Value,
		for key: StaticString
	) {
		#if DEBUG
			self.debugValues.access { (values: inout Dictionary<StaticString, Any>) -> Void in
				values[key] = value()
			}
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
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension SourceCodeMeta: Hashable {

	#if DEBUG  // ignore debug values

		public static func == (
			_ lhs: SourceCodeMeta,
			_ rhs: SourceCodeMeta
		) -> Bool {
			lhs.sourceCodeLocation == rhs.sourceCodeLocation
				&& lhs.message == rhs.message
		}

		public func hash(
			into hasher: inout Hasher
		) {
			hasher.combine(self.sourceCodeLocation)
			hasher.combine(self.message)
		}
	#endif  // use default implementation in release
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
					self.debugValues
						.access(\Dictionary<StaticString, Any>.self)
						.reduce(
							into: String(),
							{ (result, value) in
								let formattedValue: String = "\(value.value)"
									.replacingOccurrences(  // keep indentation
										of: "\n",
										with: "\n   "
									)
								result.append("\n - \(value.key): \(formattedValue)")
							}
						)
				)
		#else
			self.description
		#endif
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension SourceCodeMeta: CustomLeafReflectable {

	public var customMirror: Mirror {
		.init(
			self,
			children: [
				"message": self.message,
				"location": self.sourceCodeLocation,
			],
			displayStyle: .struct,
			ancestorRepresentation: .suppressed
		)
	}
}
