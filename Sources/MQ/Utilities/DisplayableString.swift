/// String which can be displayed to the end user.
public struct DisplayableString {

	private let value: () -> String
}

extension DisplayableString {

	/// Create instance of ``DisplayableString`` using provided value.
	public init(_ value: @autoclosure @escaping () -> String) {
		self.value = value
	}

	/// Resolved string value.
	public var string: String {
		self.value()
	}
}

extension DisplayableString {

	/// Create instance of ``DisplayableString`` using provided string with optional arguments.
	///
	/// - Parameters:
	///   - string: String used for display.
	///   Used as a format for provided arguments if any.
	///   - formatArguments: Arguments used to prepare final string
	///   treating ``string`` argument as a format.
	/// - Returns: Instance of ``DisplayableString`` using provided string.
	public static func string(
		_ string: String,
		formatArguments: CVarArg...
	) -> Self {
		if formatArguments.isEmpty {
			return .init(string)
		}
		else {
			return .init(
				String(
					format: string,
					formatArguments
				)
			)
		}
	}

	/// Create instance of ``DisplayableString`` using provided string with optional arguments.
	///
	/// - Parameters:
	///   - staticString: String used for display.
	///   Used as a format for provided arguments if any.
	///   - formatArguments: Arguments used to prepare final string
	///   treating ``string`` argument as a format.
	/// - Returns: Instance of ``DisplayableString`` using provided string.
	@_disfavoredOverload
	public static func string(
		_ staticString: StaticString,
		formatArguments: CVarArg...
	) -> Self {
		let string: String = staticString.asString
		if formatArguments.isEmpty {
			return .init(string)
		}
		else {
			return .init(
				String(
					format: string,
					formatArguments
				)
			)
		}
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension DisplayableString: CustomStringConvertible {

	public var description: String {
		self.string
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension DisplayableString: CustomDebugStringConvertible {

	public var debugDescription: String {
		self.string
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension DisplayableString: CustomLeafReflectable {

	public var customMirror: Mirror {
		.init(
			self,
			children: [],
			displayStyle: .none
		)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension DisplayableString: ExpressibleByStringInterpolation {

	public init(stringLiteral: String) {
		self.init(stringLiteral)
	}
}
