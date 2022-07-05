/// Key for localizing resources.
///
/// Type used to group localization keys
/// for the resources with use of StaticStrings.
///
/// You can define application or library constants
/// by defining static properties inside ``LocalizationKey``
/// extensions.
public struct LocalizationKey: Sendable {

	internal var rawValue: String
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension LocalizationKey: CustomStringConvertible {

	public var description: String {
		self.rawValue
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension LocalizationKey: CustomDebugStringConvertible {

	public var debugDescription: String {
		self.rawValue
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension LocalizationKey: CustomLeafReflectable {

	public var customMirror: Mirror {
		.init(
			self,
			children: [],
			displayStyle: .none
		)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension LocalizationKey: ExpressibleByStringLiteral {

	public init(stringLiteral: String) {
		self.init(rawValue: stringLiteral)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension LocalizationKey: Hashable {

	public static func == (
		_ lhs: LocalizationKey,
		_ rhs: LocalizationKey
	) -> Bool {
		lhs.rawValue == rhs.rawValue
	}

	public func hash(
		into hasher: inout Hasher
	) {
		hasher.combine(self.rawValue)
	}
}
