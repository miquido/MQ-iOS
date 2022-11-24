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
	///   - displayableMessage: Message which can be displayed
	///   to the end user. Default is "Unidentified error".
	///   - underlyingError: Underlying, unrecognized error.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: New instance of ``Unidentified`` error with given context.
	public static func error(
		message: StaticString = "Unidentified",
		displayableMessage: DisplayableString = TheErrorDisplayableMessages.message(for: Self.self),
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
			displayableMessage: displayableMessage,
			underlyingError: (underlyingError as? Unidentified)?.underlyingError ?? underlyingError
		)
	}

	/// Source code context of this error.
	public var context: SourceCodeContext
	/// String representation displayable to the end user.
	public var displayableMessage: DisplayableString
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
	///   - displayableMessage: Message which can be displayed
	///   to the end user. Default is "Unidentified error".
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: New instance of ``Unidentified`` error with given context.
	public func asUnidentified(
		message: StaticString = "Unidentified",
		displayableMessage: DisplayableString = TheErrorDisplayableMessages.message(for: Unidentified.self),
		file: StaticString = #fileID,
		line: UInt = #line
	) -> Unidentified {
		.error(
			message: message,
			displayableMessage: displayableMessage,
			underlyingError: self,
			file: file,
			line: line
		)
	}
}
