/// Location in the source code.
///
/// ``SourceCodeLocation`` keeps information about location
/// in the source code. It should be avoided in application logic.
/// Collected data is intended to be used
/// for diagnostics purposes.
public struct SourceCodeLocation {

	/// Create instance of ``SourceCodeLocation`` pointing at given location in source code.
	///
	/// Default location is this function call location.
	/// `file` and `line` arguments should not be provided manually unless it is required.
	///
	/// - Parameters:
	///   - file: Source code file identifier.
	///   Filled automatically based on compile time constants.
	///   - line: Line in given source code file.
	///   Filled automatically based on compile time constants.
	///   - column: Optional column of given line in given source code file.
	///   Filled automatically based on compile time constants.
	/// - Returns: Instance of ``SourceCodeLocation`` for given file and line.
	@_transparent
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

	@usableFromInline internal init(
		file: StaticString,
		line: UInt,
		column: UInt? = .none
	) {
		self.file = file
		self.line = line
		self.column = column
	}
}

extension SourceCodeLocation: Sendable {}

extension SourceCodeLocation: Hashable {}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension SourceCodeLocation: CustomStringConvertible {

	public var description: String {
		"\(self.file):\(self.line)\(self.column.map { ":\($0)" } ?? "")"
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
				"column": self.column as Any,
			],
			displayStyle: .struct
		)
	}
}
