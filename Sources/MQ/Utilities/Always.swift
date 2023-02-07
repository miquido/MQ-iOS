/// Convenience function helper for returning always the same value.
///
/// Makes a function returning always the same value.
/// Due to @autoclosure parameter annotation value is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter value: Value which will be always returned as a result of prepared function.
/// - Returns: Function returning always the same value.
@_transparent
public func always<V>(
	_ value: @autoclosure @escaping @Sendable () -> V
) -> @Sendable () -> V {
	value
}

/// Convenience function helper for throwing always the same error.
///
/// Makes a function throwing always the same error.
/// Due to @autoclosure parameter annotation error is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter error: Error which will be always thrown as a result of prepared function.
/// - Returns: Function throwing always the same error.
@_transparent
public func alwaysThrowing<V>(
	_ error: @autoclosure @escaping @Sendable () -> Error
) -> @Sendable () throws -> V {
	{ throw error() }
}

/// Convenience function helper for returning always the same value.
///
/// Makes a function returning always the same value.
/// Due to @autoclosure parameter annotation value is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter value: Value which will be always returned as a result of prepared function.
/// - Returns: Function returning always the same value.
@_transparent
public func always<A1, V>(
	_ value: @autoclosure @escaping @Sendable () -> V
) -> @Sendable (A1) -> V {
	{ _ in
		value()
	}
}

/// Convenience function helper for throwing always the same error.
///
/// Makes a function throwing always the same error.
/// Due to @autoclosure parameter annotation error is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter error: Error which will be always thrown as a result of prepared function.
/// - Returns: Function throwing always the same error.
@_transparent
public func alwaysThrowing<A1, V>(
	_ error: @autoclosure @escaping @Sendable () -> Error
) -> @Sendable (A1) throws -> V {
	{ _ in
		throw error()
	}
}

/// Convenience function helper for returning always the same value.
///
/// Makes a function returning always the same value.
/// Due to @autoclosure parameter annotation value is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter value: Value which will be always returned as a result of prepared function.
/// - Returns: Function returning always the same value.
@_transparent @_disfavoredOverload
public func always<A1, V>(
	_ value: @autoclosure @escaping @Sendable () -> V
) -> @Sendable (inout A1) -> V {
	{ _ in
		value()
	}
}

/// Convenience function helper for throwing always the same error.
///
/// Makes a function throwing always the same error.
/// Due to @autoclosure parameter annotation error is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter error: Error which will be always thrown as a result of prepared function.
/// - Returns: Function throwing always the same error.
@_transparent @_disfavoredOverload
public func alwaysThrowing<A1, V>(
	_ error: @autoclosure @escaping @Sendable () -> Error
) -> @Sendable (inout A1) throws -> V {
	{ _ in
		throw error()
	}
}

/// Convenience function helper for returning always the same value.
///
/// Makes a function returning always the same value.
/// Due to @autoclosure parameter annotation value is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter value: Value which will be always returned as a result of prepared function.
/// - Returns: Function returning always the same value.
@_transparent
public func always<A1, A2, V>(
	_ value: @autoclosure @escaping @Sendable () -> V
) -> @Sendable (A1, A2) -> V {
	{ _, _ in
		value()
	}
}

/// Convenience function helper for throwing always the same error.
///
/// Makes a function throwing always the same error.
/// Due to @autoclosure parameter annotation error is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter error: Error which will be always thrown as a result of prepared function.
/// - Returns: Function throwing always the same error.
@_transparent
public func alwaysThrowing<A1, A2, V>(
	_ error: @autoclosure @escaping @Sendable () -> Error
) -> @Sendable (A1, A2) throws -> V {
	{ _, _ in
		throw error()
	}
}

/// Convenience function helper for returning always the same value.
///
/// Makes a function returning always the same value.
/// Due to @autoclosure parameter annotation value is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter value: Value which will be always returned as a result of prepared function.
/// - Returns: Function returning always the same value.
@_transparent
public func always<A1, A2, A3, V>(
	_ value: @autoclosure @escaping @Sendable () -> V
) -> @Sendable (A1, A2, A3) -> V {
	{ _, _, _ in
		value()
	}
}

/// Convenience function helper for throwing always the same error.
///
/// Makes a function throwing always the same error.
/// Due to @autoclosure parameter annotation error is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter error: Error which will be always thrown as a result of prepared function.
/// - Returns: Function throwing always the same error.
@_transparent
public func alwaysThrowing<A1, A2, A3, V>(
	_ error: @autoclosure @escaping @Sendable () -> Error
) -> @Sendable (A1, A2, A3) throws -> V {
	{ _, _, _ in
		throw error()
	}
}

/// Convenience function helper for returning always the same value.
///
/// Makes a function returning always the same value.
/// Due to @autoclosure parameter annotation value is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter value: Value which will be always returned as a result of prepared function.
/// - Returns: Function returning always the same value.
@_transparent
public func always<A1, A2, A3, A4, V>(
	_ value: @autoclosure @escaping @Sendable () -> V
) -> @Sendable (A1, A2, A3, A4) -> V {
	{ _, _, _, _ in
		value()
	}
}

/// Convenience function helper for throwing always the same error.
///
/// Makes a function throwing always the same error.
/// Due to @autoclosure parameter annotation error is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter error: Error which will be always thrown as a result of prepared function.
/// - Returns: Function throwing always the same error.
@_transparent
public func alwaysThrowing<A1, A2, A3, A4, V>(
	_ error: @autoclosure @escaping @Sendable () -> Error
) -> @Sendable (A1, A2, A3, A4) throws -> V {
	{ _, _, _, _ in
		throw error()
	}
}

/// Convenience function helper for returning always the same value.
///
/// Makes a function returning always the same value.
/// Due to @autoclosure parameter annotation value is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter value: Value which will be always returned as a result of prepared function.
/// - Returns: Function returning always the same value.
@_transparent
public func always<A1, A2, A3, A4, A5, V>(
	_ value: @autoclosure @escaping @Sendable () -> V
) -> @Sendable (A1, A2, A3, A4, A5) -> V {
	{ _, _, _, _, _ in
		value()
	}
}

/// Convenience function helper for throwing always the same error.
///
/// Makes a function throwing always the same error.
/// Due to @autoclosure parameter annotation error is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter error: Error which will be always thrown as a result of prepared function.
/// - Returns: Function throwing always the same error.
@_transparent
public func alwaysThrowing<A1, A2, A3, A4, A5, V>(
	_ error: @autoclosure @escaping @Sendable () -> Error
) -> @Sendable (A1, A2, A3, A4, A5) throws -> V {
	{ _, _, _, _, _ in
		throw error()
	}
}

/// Convenience function helper for returning always the same value.
///
/// Makes a function returning always the same value.
/// Due to @autoclosure parameter annotation value is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter value: Value which will be always returned as a result of prepared function.
/// - Returns: Function returning always the same value.
@_transparent
public func always<A1, A2, A3, A4, A5, A6, V>(
	_ value: @autoclosure @escaping @Sendable () -> V
) -> @Sendable (A1, A2, A3, A4, A5, A6) -> V {
	{ _, _, _, _, _, _ in
		value()
	}
}

/// Convenience function helper for throwing always the same error.
///
/// Makes a function throwing always the same error.
/// Due to @autoclosure parameter annotation error is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter error: Error which will be always thrown as a result of prepared function.
/// - Returns: Function throwing always the same error.
@_transparent
public func alwaysThrowing<A1, A2, A3, A4, A5, A6, V>(
	_ error: @autoclosure @escaping @Sendable () -> Error
) -> @Sendable (A1, A2, A3, A4, A5, A6) throws -> V {
	{ _, _, _, _, _, _ in
		throw error()
	}
}

/// Convenience function helper for returning always the same value.
///
/// Makes a function returning always the same value.
/// Due to @autoclosure parameter annotation value is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter value: Value which will be always returned as a result of prepared function.
/// - Returns: Function returning always the same value.
@_transparent
public func always<A1, A2, A3, A4, A5, A6, A7, V>(
	_ value: @autoclosure @escaping @Sendable () -> V
) -> @Sendable (A1, A2, A3, A4, A5, A6, A7) -> V {
	{ _, _, _, _, _, _, _ in
		value()
	}
}

/// Convenience function helper for throwing always the same error.
///
/// Makes a function throwing always the same error.
/// Due to @autoclosure parameter annotation error is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter error: Error which will be always thrown as a result of prepared function.
/// - Returns: Function throwing always the same error.
@_transparent
public func alwaysThrowing<A1, A2, A3, A4, A5, A6, A7, V>(
	_ error: @autoclosure @escaping @Sendable () -> Error
) -> @Sendable (A1, A2, A3, A4, A5, A6, A7) throws -> V {
	{ _, _, _, _, _, _, _ in
		throw error()
	}
}

/// Convenience function helper for returning always the same value.
///
/// Makes a function returning always the same value.
/// Due to @autoclosure parameter annotation value is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter value: Value which will be always returned as a result of prepared function.
/// - Returns: Function returning always the same value.
@_transparent
public func always<A1, A2, A3, A4, A5, A6, A7, A8, V>(
	_ value: @autoclosure @escaping @Sendable () -> V
) -> @Sendable (A1, A2, A3, A4, A5, A6, A7, A8) -> V {
	{ _, _, _, _, _, _, _, _ in
		value()
	}
}

/// Convenience function helper for throwing always the same error.
///
/// Makes a function throwing always the same error.
/// Due to @autoclosure parameter annotation error is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter error: Error which will be always thrown as a result of prepared function.
/// - Returns: Function throwing always the same error.
@_transparent
public func alwaysThrowing<A1, A2, A3, A4, A5, A6, A7, A8, V>(
	_ error: @autoclosure @escaping @Sendable () -> Error
) -> @Sendable (A1, A2, A3, A4, A5, A6, A7, A8) throws -> V {
	{ _, _, _, _, _, _, _, _ in
		throw error()
	}
}
