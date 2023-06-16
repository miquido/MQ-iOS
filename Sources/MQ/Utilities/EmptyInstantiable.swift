/// ``EmptyInstantiable`` is a type which
/// can be instantiated without any additional
/// arguments making empty (default) instance.
public protocol EmptyInstantiable {

	/// Get the empty instance.
	static var empty: Self { get }
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension StaticString: EmptyInstantiable {

	@inline(__always) @_transparent @_semantics("constant_evaluable")
	public static var empty: Self { .init() }
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension String: EmptyInstantiable {

	@inline(__always) @_transparent @_semantics("constant_evaluable")
	public static var empty: Self { .init() }
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Substring: EmptyInstantiable {

	@inline(__always) @_transparent @_semantics("constant_evaluable")
	public static var empty: Self { .init() }
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Set: EmptyInstantiable {

	@inline(__always) @_transparent @_semantics("constant_evaluable")
	public static var empty: Self { .init() }
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Array: EmptyInstantiable {

	@inline(__always) @_transparent @_semantics("constant_evaluable")
	public static var empty: Self { .init() }
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension ArraySlice: EmptyInstantiable {

	@inline(__always) @_transparent @_semantics("constant_evaluable")
	public static var empty: Self { .init() }
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension KeyValuePairs: EmptyInstantiable {

	@inline(__always) @_transparent @_semantics("constant_evaluable")
	public static var empty: Self { .init() }
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension Dictionary: EmptyInstantiable {

	@inline(__always) @_transparent @_semantics("constant_evaluable")
	public static var empty: Self { .init() }
}
