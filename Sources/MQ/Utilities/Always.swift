/// Convenience function helper for returning always the same value.
///
/// Makes a function returning always the same value.
/// Due to @autoclosure parameter annotation value is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter value: Value which will be always returned as a result of prepared function.
/// - Returns: Function returning always the same value.
@inlinable
public func always<V>(
	_ value: @autoclosure @escaping () -> V
) -> () -> V {
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
@inlinable
public func alwaysThrowing<V>(
  _ error: @autoclosure @escaping () -> Error
) -> () throws -> V {
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
@inlinable
public func alwaysAsync<V>(
  _ value: @autoclosure @escaping () -> V
) -> () async -> V {
  { value() }
}

/// Convenience function helper for throwing always the same error.
///
/// Makes a function throwing always the same error.
/// Due to @autoclosure parameter annotation error is resolved on demand
/// and becomes captured by argument closure when used.
///
/// - Parameter error: Error which will be always thrown as a result of prepared function.
/// - Returns: Function throwing always the same error.
@inlinable
public func alwaysAsyncThrowing<V>(
  _ error: @autoclosure @escaping () -> Error
) -> () async throws -> V {
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
@inlinable
public func always<A1, V>(
	_ value: @autoclosure @escaping () -> V
) -> (A1) -> V {
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
@inlinable
public func alwaysThrowing<A1, V>(
  _ error: @autoclosure @escaping () -> Error
) -> (A1) throws -> V {
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
@inlinable
public func always<A1, V>(
  _ value: @autoclosure @escaping () -> V
) -> (inout A1) -> V {
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
@inlinable
public func alwaysThrowing<A1, V>(
  _ error: @autoclosure @escaping () -> Error
) -> (inout A1) throws -> V {
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
@inlinable
public func alwaysAsync<A1, V>(
  _ value: @autoclosure @escaping () -> V
) -> (A1) async -> V {
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
@inlinable
public func alwaysAsyncThrowing<A1, V>(
  _ error: @autoclosure @escaping () -> Error
) -> (A1) async throws -> V {
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
@inlinable
public func always<A1, A2, V>(
  _ value: @autoclosure @escaping () -> V
) -> (A1, A2) -> V {
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
@inlinable
public func alwaysThrowing<A1, A2, V>(
	_ error: @autoclosure @escaping () -> Error
) -> (A1, A2) throws -> V {
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
@inlinable
public func alwaysAsync<A1, A2, V>(
  _ value: @autoclosure @escaping () -> V
) -> (A1, A2) async -> V {
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
@inlinable
public func alwaysAsyncThrowing<A1, A2, V>(
  _ error: @autoclosure @escaping () -> Error
) -> (A1, A2) async throws -> V {
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
@inlinable
public func always<A1, A2, A3, V>(
  _ value: @autoclosure @escaping () -> V
) -> (A1, A2, A3) -> V {
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
@inlinable
public func alwaysThrowing<A1, A2, A3, V>(
	_ error: @autoclosure @escaping () -> Error
) -> (A1, A2, A3) throws -> V {
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
@inlinable
public func alwaysAsync<A1, A2, A3, V>(
  _ value: @autoclosure @escaping () -> V
) -> (A1, A2, A3) async -> V {
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
@inlinable
public func alwaysAsyncThrowing<A1, A2, A3, V>(
  _ error: @autoclosure @escaping () -> Error
) -> (A1, A2, A3) async throws -> V {
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
@inlinable
public func always<A1, A2, A3, A4, V>(
  _ value: @autoclosure @escaping () -> V
) -> (A1, A2, A3, A4) -> V {
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
@inlinable
public func alwaysThrowing<A1, A2, A3, A4, V>(
	_ error: @autoclosure @escaping () -> Error
) -> (A1, A2, A3, A4) throws -> V {
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
@inlinable
public func alwaysAsync<A1, A2, A3, A4, V>(
  _ value: @autoclosure @escaping () -> V
) -> (A1, A2, A3, A4) async -> V {
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
@inlinable
public func alwaysAsyncThrowing<A1, A2, A3, A4, V>(
  _ error: @autoclosure @escaping () -> Error
) -> (A1, A2, A3, A4) async throws -> V {
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
@inlinable
public func always<A1, A2, A3, A4, A5, V>(
  _ value: @autoclosure @escaping () -> V
) -> (A1, A2, A3, A4, A5) -> V {
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
@inlinable
public func alwaysThrowing<A1, A2, A3, A4, A5, V>(
	_ error: @autoclosure @escaping () -> Error
) -> (A1, A2, A3, A4, A5) throws -> V {
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
@inlinable
public func alwaysAsync<A1, A2, A3, A4, A5, V>(
  _ value: @autoclosure @escaping () -> V
) -> (A1, A2, A3, A4, A5) async -> V {
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
@inlinable
public func alwaysAsyncThrowing<A1, A2, A3, A4, A5, V>(
  _ error: @autoclosure @escaping () -> Error
) -> (A1, A2, A3, A4, A5) async throws -> V {
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
@inlinable
public func always<A1, A2, A3, A4, A5, A6, V>(
	_ value: @autoclosure @escaping () -> V
) -> (A1, A2, A3, A4, A5, A6) -> V {
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
@inlinable
public func alwaysThrowing<A1, A2, A3, A4, A5, A6, V>(
  _ error: @autoclosure @escaping () -> Error
) -> (A1, A2, A3, A4, A5, A6) throws -> V {
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
@inlinable
public func alwaysAsync<A1, A2, A3, A4, A5, A6, V>(
  _ value: @autoclosure @escaping () -> V
) -> (A1, A2, A3, A4, A5, A6) async -> V {
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
@inlinable
public func alwaysAsyncThrowing<A1, A2, A3, A4, A5, A6, V>(
  _ error: @autoclosure @escaping () -> Error
) -> (A1, A2, A3, A4, A5, A6) async throws -> V {
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
@inlinable
public func always<A1, A2, A3, A4, A5, A6, A7, V>(
  _ value: @autoclosure @escaping () -> V
) -> (A1, A2, A3, A4, A5, A6, A7) -> V {
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
@inlinable
public func alwaysThrowing<A1, A2, A3, A4, A5, A6, A7, V>(
	_ error: @autoclosure @escaping () -> Error
) -> (A1, A2, A3, A4, A5, A6, A7) throws -> V {
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
@inlinable
public func alwaysAsync<A1, A2, A3, A4, A5, A6, A7, V>(
  _ value: @autoclosure @escaping () -> V
) -> (A1, A2, A3, A4, A5, A6, A7) async -> V {
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
@inlinable
public func alwaysAsyncThrowing<A1, A2, A3, A4, A5, A6, A7, V>(
  _ error: @autoclosure @escaping () -> Error
) -> (A1, A2, A3, A4, A5, A6, A7) async throws -> V {
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
@inlinable
public func always<A1, A2, A3, A4, A5, A6, A7, A8, V>(
	_ value: @autoclosure @escaping () -> V
) -> (A1, A2, A3, A4, A5, A6, A7, A8) -> V {
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
@inlinable
public func alwaysThrowing<A1, A2, A3, A4, A5, A6, A7, A8, V>(
  _ error: @autoclosure @escaping () -> Error
) -> (A1, A2, A3, A4, A5, A6, A7, A8) throws -> V {
  { _, _, _, _, _, _, _, _ in
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
@inlinable
public func alwaysAsync<A1, A2, A3, A4, A5, A6, A7, A8, V>(
  _ value: @autoclosure @escaping () -> V
) -> (A1, A2, A3, A4, A5, A6, A7, A8) async -> V {
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
@inlinable
public func alwaysAsyncThrowing<A1, A2, A3, A4, A5, A6, A7, A8, V>(
  _ error: @autoclosure @escaping () -> Error
) -> (A1, A2, A3, A4, A5, A6, A7, A8) async throws -> V {
  { _, _, _, _, _, _, _, _ in
    throw error()
  }
}
