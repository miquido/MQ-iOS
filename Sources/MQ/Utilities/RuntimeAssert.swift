/// Method backing ``runtimeAssert`` implementation.
///
/// Default implementation is using Swift assert which is removed in release builds.
/// You can replace this implementation if needed.
///
/// - warning: If you replace this implementation you are responsible for release behaviour of it.
///
/// - warning: Implementation exchange is not thread safe.
public var runtimeAssertionMethod:
	(
		_ condition: () -> Bool,
		_ message: String,
		_ file: StaticString,
		_ line: UInt
	) -> Void = { condition, message, file, line in
		assert(
			condition(),
			message,
			file: file,
			line: line
		)
	}

/// Replacement for Swift ``assert``.
///
/// Runtime assertion as replacement for Swift assert.
/// Can be manually replaced by replacing ``runtimeAssertionMethod`` implementation.
///
/// - Parameters:
///   - condition: Condition to be verivied. Asserion passes if it returns true.
///   - message: Message associated with failure.
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
public func runtimeAssert(
	_ condition: @autoclosure () -> Bool,
	message: String,
	file: StaticString = #fileID,
	line: UInt = #line
) {
	runtimeAssertionMethod(
		condition,
		message,
		file,
		line
	)
}

/// Replacement for Swift ``assertionFailure``.
///
/// Runtime assertion failure as replacement for Swift assertionFailure.
/// Can be manually replaced by replacing ``runtimeAssertionMethod`` implementation.
///
/// - Parameters:
///   - message: Message associated with failure.
///   - file: Source code file identifier.
///   Filled automatically based on compile time constants.
///   - line: Line in given source code file.
///   Filled automatically based on compile time constants.
public func runtimeAssertionFailure(
	message: String,
	file: StaticString = #fileID,
	line: UInt = #line
) {
	runtimeAssertionMethod(
		{ false },
		message,
		file,
		line
	)
}
