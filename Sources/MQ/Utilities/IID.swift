/// Internal instance identifier.
///
/// IID (Instance IDentifier) is an identifier which can be used
/// to distinguish or match instance of any other type.
///
/// As an example it can be used to identify
/// functions stored in dictionary:
///
/// ```swift
/// var observers: Dictionary<IID, (Value) -> Void> = ...
/// ```
///
/// Each instance of IID is treated as unique.
/// Any two instances of it will not be equal but
/// the same instance will always be equal to itself.
///
/// - Note: IID can be used only outside of domain based code.
/// It is intended to provide quick access to stable keys and unique
/// identifiers for operations not leaving the application.
@propertyWrapper public final class IID {

	// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
	public var wrappedValue: IID { self }

	/// Create new instance of IID.
	public init() {}
}

extension IID: Sendable {}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension IID: Equatable {

	public static func == (
		_ lhs: IID,
		_ rhs: IID
	) -> Bool {
		lhs === rhs
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension IID: Hashable {

	public func hash(
		into hasher: inout Hasher
	) {
		hasher.combine(ObjectIdentifier(self))
	}
}
