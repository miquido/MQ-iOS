/// ``EmptyInstantiable`` is a type which
/// can be instantiated without any additional
/// arguments making default / zero value instance.
public protocol EmptyInstantiable {

	/// Empty instance with default / zero value.
	static var empty: Self { get }
}
