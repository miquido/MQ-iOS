extension StaticString {

	/// Check if the string is empty.
	///
	/// - Returns: `true` if string is empty, `false` otherwise.
	///
	/// - note: String containing only whitespace characters is not empty.
	@inlinable public var isEmpty: Bool {
		self.asString.isEmpty
	}
}
