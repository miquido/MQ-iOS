/// Unique identifier of TheError type.
///
/// ``TheErrorID`` is an identifier available
/// to all types of ``TheError``. It is based
/// on the actual error type ignoring its instance
/// variables.
public struct TheErrorID {

	private let identifier: ObjectIdentifier

	internal init<ErrorType>(
		_: ErrorType.Type
	) where ErrorType: TheError {
		self.identifier = .init(ErrorType.self)
	}
}

extension TheErrorID: Hashable {}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension TheErrorID: Identifiable {

	public var id: Self { self }
}
