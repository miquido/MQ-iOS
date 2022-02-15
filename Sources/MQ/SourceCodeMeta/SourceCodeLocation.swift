/// Location in the source code.
///
/// ``SourceCodeLocation`` should be always avoided in application logic.
/// Collected data should be used only for diagnostics purposes.
///
/// - warning: ``SourceCodeLocation`` is not intended to provide any data across application.
public struct SourceCodeLocation {

	/// Create instance of ``SourceCodeLocation`` pointing at given location in source code.
	///
	/// Default location provided is this function call location.
	/// `file` and `line` arguments should not be provided manually unless it is required.
	///
	/// - Parameters:
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	///   - column: Optional column in given line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: Instance of ``SourceCodeLocation`` for given file and line.
	public static func here(
		file: StaticString = #fileID,
		line: UInt = #line,
		column: UInt? = #column
	) -> Self {
		Self(
			file: file,
			line: line,
			column: column
		)
	}

	private let file: StaticString
	private let line: UInt
	private let column: UInt?
}

extension SourceCodeLocation: Hashable {}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension SourceCodeLocation: CustomStringConvertible {

	public var description: String {
		"\(self.file)@\(self.line)\(self.column.map { ":\($0)" } ?? "")"
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension SourceCodeLocation: CustomDebugStringConvertible {

	public var debugDescription: String {
		self.description
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension SourceCodeLocation: CustomLeafReflectable {

	public var customMirror: Mirror {
		.init(
			self,
			children: [
				"file": self.file,
				"line": self.line,
				"column": self.column,
			],
			displayStyle: .struct,
			ancestorRepresentation: .suppressed
		)
	}
}
