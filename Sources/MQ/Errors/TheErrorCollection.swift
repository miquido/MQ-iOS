/// ``TheErrorCollection`` is a type which allows to collect
/// multiple instances of ``TheError`` inside a single one.
/// This is intended to gather multiple issues which can cause failure
/// withing a single instance which then can be passed and handled easier.
public protocol TheErrorCollection: TheError {

	/// Collection of collected errors.
	/// Ordering of added errors should be preserved.
	var errors: Array<TheError> { get }

	/// Add a new error to the collection.
	///
	/// Added errors should not directly modify the collection.
	/// Ordering of added errors should be preserved.
	/// This inclueds assumption that added errors won't modify the error ``context``.
	///
	/// - Parameter other: Other error to be added to this collection.
	mutating func add(
		_ other: TheError
	)
}

extension TheErrorCollection {

	/// Add a new error to this collection copy.
	///
	/// Added errors should not directly modify the collection.
	/// Ordering of added errors should be preserved.
	/// This inclueds assumption that added errors won't modify the error ``context``.
	///
	/// - Parameter other: Other error to be added to this collection copy.
	/// - Returns: Copy of this error with additional error in collection.
	public func adding(
		_ other: TheError
	) -> TheError {
		var copy: Self = self
		copy.add(other)
		return copy
	}
}
