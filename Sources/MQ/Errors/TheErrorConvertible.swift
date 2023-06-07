/// Type convertible to ``TheError``.
///
/// Type which can be representable by instance of ``TheError``.
/// This conversion will be executed automatically when using
/// ``asTheError`` error conversion.
public protocol TheErrorConvertible {

	func convertToTheError(
		file: StaticString,
		line: UInt
	) -> TheError
}
