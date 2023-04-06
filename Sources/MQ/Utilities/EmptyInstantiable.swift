/// ``EmptyInstantiable`` is a type which
/// can be instantiated without any additional
/// arguments making empty (default) instance.
public protocol EmptyInstantiable {

	/// Get the empty instance.
	static var empty: Self { get }
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension StaticString: EmptyInstantiable {

	public static var empty: Self { .init() }
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension String: EmptyInstantiable {

	public static var empty: Self { .init() }
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Substring: EmptyInstantiable {

	public static var empty: Self { .init() }
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Set: EmptyInstantiable {

	public static var empty: Self { .init() }
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Array: EmptyInstantiable {

	public static var empty: Self { .init() }
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension ArraySlice: EmptyInstantiable {

	public static var empty: Self { .init() }
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension KeyValuePairs: EmptyInstantiable {

	public static var empty: Self { .init() }
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Dictionary: EmptyInstantiable {

	public static var empty: Self { .init() }
}
