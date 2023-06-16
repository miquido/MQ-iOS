/// ``TheError`` for unidentified errors.
///
/// ``Unidentified`` error can occur when failure occurs but it is not handled or identified properly.
/// It is meant to be used as a fallback conversion from base ``Error`` interface to ``TheError``
/// where conversion to a concrete instance of ``TheError`` is not possible.
/// Context of wrapped error will be prepended to the ``Unidentified`` context in order
/// to keep track of actual error in error description with non debug builds.
public struct Unidentified: TheError {

	/// Create instance of ``Unidentified`` error.
	///
	/// - Parameters:
	///   - message: Message associated with this error.
	///   Default value is "Unidentified".
	///   - group: ``TheErrorGroup`` associated with this error instance.
	///   Default value is ``TheErrorGroup.default``.
	///   - underlyingError: Underlying, unrecognized error.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: New instance of ``Unidentified`` error with given context.
	public static func error(
		message: StaticString = "Unidentified",
		group: TheErrorGroup = .default,
		underlyingError: Error,
		file: StaticString = #fileID,
		line: UInt = #line
	) -> Self {
		Self(
			context: (underlyingError as? TheError)?
				.context
				.appending(
					.message(
						message,
						file: file,
						line: line
					)
				)
				?? .context(
					message: message,
					file: file,
					line: line
				),
			group: group,
			underlyingError: (underlyingError as? Unidentified)?.underlyingError ?? underlyingError
		)
	}

	/// Source code context of this error.
	public var context: SourceCodeContext
	/// Error group associated with this error instance.
	public var group: TheErrorGroup
	/// Underlying, unrecognized error if any.
	public var underlyingError: Error
}

extension Error {

	/// Convert the error to ``Unidentified`` error.
	///
	/// `underlyingError` of newly created error will be this error instance.
	///
	/// - Parameters:
	///   - message: Message associated with this error conversion.
	///   Default value is "Unidentified".
	///   - group: ``TheErrorGroup`` associated with this error instance.
	///   Default value is ``TheErrorGroup.default``.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: New instance of ``Unidentified`` error with given context.
	public func asUnidentified(
		message: StaticString = "Unidentified",
		group: TheErrorGroup = .default,
		file: StaticString = #fileID,
		line: UInt = #line
	) -> Unidentified {
		.error(
			message: message,
			group: group,
			underlyingError: self,
			file: file,
			line: line
		)
	}
}
