/// ``DisplayableWithString`` is a type which
/// can be displayed on the scren / presented to
/// the user by using string value.
public protocol DisplayableWithString {

	/// Get the string representation of this type
	/// which can be presented on the screen.
	nonisolated var displayableString: DisplayableString { get }
}
