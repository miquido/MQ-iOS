/// Convenience function helper for returning always the same value.
///
/// Makes a function returning always the same value.
/// Due to @autoclosure parameter annotation value is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter value: Value which will be always returned as a result of prepared function.
/// - Returns: Function returning always the same value.
public func always<V>(
	_ value: @autoclosure @escaping () -> V
) -> () -> V {
	value
}

/// Convenience function helper for returning always the same value.
///
/// Makes a function returning always the same value.
/// Due to @autoclosure parameter annotation value is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter value: Value which will be always returned as a result of prepared function.
/// - Returns: Function returning always the same value.
public func always<A1, V>(
	_ value: @autoclosure @escaping () -> V
) -> (A1) -> V {
	{ _ in
		value()
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
public func always<A1, A2, V>(
	_ value: @autoclosure @escaping () -> V
) -> (A1, A2) -> V {
	{ _, _ in
		value()
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
public func always<A1, A2, A3, V>(
	_ value: @autoclosure @escaping () -> V
) -> (A1, A2, A3) -> V {
	{ _, _, _ in
		value()
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
public func always<A1, A2, A3, A4, V>(
	_ value: @autoclosure @escaping () -> V
) -> (A1, A2, A3, A4) -> V {
	{ _, _, _, _ in
		value()
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
public func always<A1, A2, A3, A4, A5, V>(
	_ value: @autoclosure @escaping () -> V
) -> (A1, A2, A3, A4, A5) -> V {
	{ _, _, _, _, _ in
		value()
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
public func always<A1, A2, A3, A4, A5, A6, V>(
	_ value: @autoclosure @escaping () -> V
) -> (A1, A2, A3, A4, A5, A6) -> V {
	{ _, _, _, _, _, _ in
		value()
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
public func always<A1, A2, A3, A4, A5, A6, A7, V>(
	_ value: @autoclosure @escaping () -> V
) -> (A1, A2, A3, A4, A5, A6, A7) -> V {
	{ _, _, _, _, _, _, _ in
		value()
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
public func always<A1, A2, A3, A4, A5, A6, A7, A8, V>(
	_ value: @autoclosure @escaping () -> V
) -> (A1, A2, A3, A4, A5, A6, A7, A8) -> V {
	{ _, _, _, _, _, _, _, _ in
		value()
	}
}
