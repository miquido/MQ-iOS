extension StaticString {

	/// Check whenever the string is empty.
	///
	/// - Returns: `true` if string is empty, `false` otherwise.
	///
	/// - note: String containing only whitespace characters is not empty.
	public var isEmpty: Bool {
		self.asString.isEmpty
	}
}
