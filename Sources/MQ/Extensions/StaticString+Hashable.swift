// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension StaticString: Hashable {

	public static func == (
		_ lhs: StaticString,
		_ rhs: StaticString
	) -> Bool {
		lhs.asString == rhs.asString
	}

	public func hash(
		into hasher: inout Hasher
	) {
		hasher.combine(self.asString)
	}
}
