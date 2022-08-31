public struct TheErrorGroup {

	private var identifiers: Array<Identifier>
}

extension TheErrorGroup {

	public struct Identifier {

		private let identifier: StaticString
	}
}

extension TheErrorGroup.Identifier: Hashable {}

extension TheErrorGroup.Identifier: ExpressibleByStringLiteral {

	public init(
		stringLiteral value: StaticString
	) {
		self.identifier = value
	}
}

extension TheErrorGroup: Hashable {}

extension TheErrorGroup: ExpressibleByStringLiteral {

	public init(
		stringLiteral value: StaticString
	) {
		self.identifiers = [.init(stringLiteral: value)]
	}
}

extension TheErrorGroup: ExpressibleByArrayLiteral {

	public init(
		arrayLiteral elements: TheErrorGroup.Identifier...
	) {
		self.identifiers = .init(elements)
	}
}

extension TheErrorGroup {

	public static let `default`: Self = .init()

	@usableFromInline internal func firstMatchingIdentifier(
		_ matches: (Identifier) -> Bool
	) -> Identifier? {
		self.identifiers.first(where: matches)
	}
}
