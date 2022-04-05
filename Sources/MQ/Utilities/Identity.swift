/// Convenience helper for identity function.
///
/// Identity function is a function which returns
/// exactly the same value as provided as argument
/// without any modifications.
///
/// - Parameter value: Value forwarded.
/// - Returns: Value provided as an argument without any changes.
public func id<Value>(
	_ value: Value
) -> Value {
	value
}
