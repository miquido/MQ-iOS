@propertyWrapper
internal final class Lazy<Value> {

	internal private(set) lazy var wrappedValue: Value = {
		defer {
			// cleanup memory, after initializing wrappedValue,
			// initialize function will not be used again
			self.initialize = .none
		}
		return self.initialize()
	}()
	// swift-format-ignore: NeverUseImplicitlyUnwrappedOptionals
	private var initialize: (() -> Value)!

	internal init(
		_ initialize: @escaping () -> Value
	) {
		self.initialize = initialize
	}

	internal init(
		_ initialize: @autoclosure @escaping () -> Value
	) {
		self.initialize = initialize
	}
}
