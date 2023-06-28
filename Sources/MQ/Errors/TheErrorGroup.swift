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

	private let identifiers: Array<Identifier>
}

extension TheErrorGroup {

	/// Merge multiple error groups.
	///
	/// Note that ordering matters.
	public static func merging(
		_ head: TheErrorGroup,
		_ mid: TheErrorGroup,
		_ tail: TheErrorGroup...
	) -> Self {
		.merging([head, mid] + tail)
	}

	/// Merge multiple error groups.
	///
	/// Note that ordering matters.
	public static func merging(
		_ groups: Array<TheErrorGroup>
	) -> Self {
		var added: Set<TheErrorGroup.Identifier> = .init()
		var result: Array<TheErrorGroup.Identifier> = .init()
		for identifier in groups.flatMap(\.identifiers) {
			if added.contains(identifier) {
				continue  // skip duplicates
			}
			else {
				result.append(identifier)
				added.insert(identifier)
			}
		}

		return .init(
			identifiers: result
		)
	}
}

extension TheErrorGroup {

	/// Identifier of error group.
	public struct Identifier {

		fileprivate let identifier: StaticString
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

	internal func firstMatchingIdentifier(
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
extension TheErrorGroup: CustomStringConvertible {

	public var description: String {
		self.identifiers.reduce(into: "∙") { (result: inout String, element: Identifier) in
			result.append("\(element.identifier)∙")
		}
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension TheErrorGroup: CustomDebugStringConvertible {

	public var debugDescription: String {
		self.description
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension TheErrorGroup: CustomLeafReflectable {

	public var customMirror: Mirror {
		.init(
			self,
			children: [
				"identifiers": self.identifiers.map(\.identifier)
			],
			displayStyle: .tuple
		)
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

extension TheErrorGroup.Identifier {

	public static func ~= (
		_ lhs: TheErrorGroup.Identifier,
		_ rhs: Error
	) -> Bool {
		((rhs as? TheError)?.group)?.identifiers.contains(lhs) ?? false
	}
}
