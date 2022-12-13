/// Group of errors.
///
/// ``TheErrorGroup`` is a structure used to tag
/// errors to allow easier grouping and hadling
/// of similar or related errors.
///
/// - Note: ``TheErrorGroup`` can be defined using
/// more than one identifier. Order of identifiers
/// mattrers. It is used i.e. to find matching
/// messages from ``TheErrorDisplayableMessages``.
public struct TheErrorGroup {

	private var identifiers: Array<Identifier>
}

extension TheErrorGroup {

	/// Identifier of error group.
	public struct Identifier {

		private let identifier: StaticString
	}
}

extension TheErrorGroup.Identifier: Hashable {}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension TheErrorGroup.Identifier: ExpressibleByStringLiteral {

	public init(
		stringLiteral value: StaticString
	) {
		self.identifier = value
	}
}

extension TheErrorGroup: Hashable {}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension TheErrorGroup: ExpressibleByStringLiteral {

	public init(
		stringLiteral value: StaticString
	) {
		self.identifiers = [.init(stringLiteral: value)]
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension TheErrorGroup: ExpressibleByArrayLiteral {

	public init(
		arrayLiteral elements: TheErrorGroup.Identifier...
	) {
		self.identifiers = .init(elements)
	}
}

extension TheErrorGroup {

	/// Default error group.
	///
	/// All errors are implicitly matching this group.
	public static let `default`: Self = .init()
}

extension TheErrorGroup {

	@usableFromInline internal func firstMatchingIdentifier(
		_ matches: (Identifier) -> Bool
	) -> Identifier? {
		self.identifiers.first(where: matches)
	}

	internal func isSubset(
		of other: Self
	) -> Bool {
		for identifier in self.identifiers {
			guard other.identifiers.contains(identifier)
			else { return false }
		}

		return true
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension TheErrorGroup {

	public static func ~= (
		_ lhs: TheErrorGroup,
		_ rhs: Error
	) -> Bool {
		((rhs as? TheError)?.group).map(lhs.isSubset(of:)) ?? false
	}
}
