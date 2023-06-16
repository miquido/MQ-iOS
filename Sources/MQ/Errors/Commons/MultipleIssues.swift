/// ``MultipleIssues`` is a wrapper for multiple errors.
///
/// It behaves both as ``TheErrorComposite`` and ``TheErrorCollection``.
/// This means that ``MultipleIssues`` can collect multiple instances of
/// other errors to be used later and merge other errors to keep diagnostics
/// data while using single error instance. Merge is implemented by simple
/// ``context`` merge.
public struct MultipleIssues: TheError {

	/// Create instance of ``MultipleIssues`` error.
	///
	/// - Parameters:
	///   - message: Message associated with this error.
	///   Default value is "MultipleIssues".
	///   - displayableMessageExtraction: Function used to extract ``displayableString``
	///   for this error. It allows to examine contained errors collection to select
	///   the most appropriate message to display. Default value is based on ``TheErrorDisplayableMessages``.
	///   - errors: Initial array of other errors to be inside collection.
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: New instance of ``MultipleIssues`` error with given context.
	public static func error(
		message: StaticString = "MultipleIssues",
		displayableMessageExtraction: @escaping (Self) -> DisplayableString = { (self: Self) -> DisplayableString in
			TheErrorDisplayableMessages.message(for: self)
		},
		collecting errors: TheError...,
		file: StaticString = #fileID,
		line: UInt = #line
	) -> Self {
		Self(
			context: .context(
				message: message,
				file: file,
				line: line
			),
			group: .merging(errors.map(\.group)),
			errors: errors,
			displayableMessageExtraction: displayableMessageExtraction
		)
	}

	/// Source code context of this error.
	public var context: SourceCodeContext
	/// Error group associated with this error instance.
	public var group: TheErrorGroup

	public var errors: Array<TheError>
	public var displayableString: DisplayableString {
		self.displayableMessageExtraction(self)
	}

	private let displayableMessageExtraction: (Self) -> DisplayableString
}

extension MultipleIssues: TheErrorCollection {

	public mutating func add(
		_ other: TheError
	) {
		self.group = .merging(self.group, other.group)
		self.errors.append(other)
	}
}

extension MultipleIssues: CustomLeafReflectable {

	public var customMirror: Mirror {
		.init(
			self,
			children: [
				"errors": self.errors
			],
			displayStyle: .struct
		)
	}
}
