/// Source code metadata conected with a location in source code.
///
/// ``SourceCodeMeta`` is a structure to collect metadata
/// and diagnostics across application. It associates
/// a message and optional debug values with given location is code.
/// Collected data is intended to be used
/// for diagnostics purposes.
public struct SourceCodeMeta: Sendable {

	/// Create ``SourceCodeMeta`` using given source code location.
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
	/// - Returns: Instance of ``SourceCodeMeta`` with provided message and location.
	public static func message(
		_ message: StaticString,
		file: StaticString = #fileID,
		line: UInt = #line
	) -> Self {
		Self(
			message: message,
			location: .here(
				file: file,
				line: line
			)
		)
	}

	private let message: StaticString
	private let location: SourceCodeLocation
	#if DEBUG
		private var debugValues: Dictionary<StaticString, Sendable> = .init()
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
	) where Value: Sendable {
		#if DEBUG
			self.debugValues[key] = value()
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
	) -> Self
	where Value: Sendable {
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
			lhs.location == rhs.location
				&& lhs.message == rhs.message
		}

		public func hash(
			into hasher: inout Hasher
		) {
			hasher.combine(self.location)
			hasher.combine(self.message)
		}
	#endif  // use default implementation in release
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension SourceCodeMeta: CustomStringConvertible {

	public var description: String {
		var description: String = "\(self.location.description)"

		if !self.message.isEmpty {
			description.append(" - \" \(self.message.asString)")
		}  // else noop

		return description
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension SourceCodeMeta: CustomDebugStringConvertible {

	public var debugDescription: String {
		#if DEBUG
			var description: String = self.description

			if !self.debugValues.isEmpty {
				let debugValuesDescription: String = self.debugValues
					.reduce(
						into: String(),
						{ (result, value) in
							let formattedValue: String = "\(value.value)"
								.replacingOccurrences(  // keep indentation
									of: "\n",
									with: "\n   "
								)
							result.append("\n • \(value.key): \(formattedValue)")
						}
					)
				description.append("\n\(debugValuesDescription)")
			}  // else noop

			return description
		#else
			self.description
		#endif
	}

	internal var prettyDescription: String {
		var description: String = " 📍 \(self.location.description)"

		if !self.message.isEmpty {
			description
				.append("\n⎜ ✉️ \(self.message.asString.replacingOccurrences(of: "\n", with: "\n⎜ ")) ")
		}  // else noop

		#if DEBUG
			if !self.debugValues.isEmpty {
				let debugValuesDescription: String = self.debugValues
					.reduce(
						into: String(),
						{ (result, element) in
							let formattedValue: String = .init(reflecting: element.value)
								.replacingOccurrences(  // keep indentation
									of: "\n",
									with: "\n⎜ ⮑ "
								)
							result.append("\n⎜ 🧩 \(element.key): \(formattedValue)")
						}
					)
				description.append("\(debugValuesDescription)")
			}  // else noop
		#endif

		return description
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension SourceCodeMeta: CustomLeafReflectable {

	public var customMirror: Mirror {
		.init(
			self,
			children: [
				"message": self.message,
				"location": self.location,
			],
			displayStyle: .struct
		)
	}
}
