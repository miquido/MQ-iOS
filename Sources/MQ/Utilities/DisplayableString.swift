import class Foundation.Bundle
import func Foundation.NSLocalizedString

/// String which can be displayed to the end user.
public struct DisplayableString: Sendable {

	/// Resolved string value to display.
	public let resolved: String

	/// Create instance of ``DisplayableString`` using provided value.
	///
	/// - Parameter value: Lazily resolved string value.
	/// Resolved value will be cached after accessing if for
	/// the first time and won't be updated after.
	///
	/// - Note: `value` is captured using autoclosure
	/// to be lazily eveluated when needed. It should be
	/// avoided to make time consuming operations
	/// and thread blocking when resolving value
	/// to avoid unexpected behaviour.
	public init(
		_ value: @autoclosure @escaping @Sendable () -> String
	) {
		self.resolved = value()
	}
}

extension DisplayableString {

	/// Create instance of ``DisplayableString`` using provided string with optional arguments.
	///
	/// - Parameters:
	///   - string: String used for display.
	///   Used as a format for provided arguments if any.
	///   - formatArguments: Arguments used to prepare final string
	///   treating ``string`` argument as a format.
	/// - Returns: Instance of ``DisplayableString`` using provided string.
	public static func string(
		_ string: String,
		formatArguments: CVarArg...
	) -> Self {
		if formatArguments.isEmpty {
			return .init(string)
		}
		else {
			return .init(
				String(
					format: string,
					formatArguments
				)
			)
		}
	}

	/// Create instance of ``DisplayableString`` using provided string with optional arguments.
	///
	/// - Parameters:
	///   - staticString: String used for display.
	///   Used as a format for provided arguments if any.
	///   - formatArguments: Arguments used to prepare final string
	///   treating ``string`` argument as a format.
	/// - Returns: Instance of ``DisplayableString`` using provided string.
	@_disfavoredOverload
	public static func string(
		_ staticString: StaticString,
		formatArguments: CVarArg...
	) -> Self {
		let string: String = staticString.asString
		if formatArguments.isEmpty {
			return .init(string)
		}
		else {
			return .init(
				String(
					format: string,
					formatArguments
				)
			)
		}
	}

	/// Create instance of ``DisplayableString`` using provided value with formatter.
	///
	/// - Parameters:
	///   - value: Value converted to a String using provided formatter.
	///   - formatter: Function used to convert provided value
	///   to a String.
	/// - Returns: Instance of ``DisplayableString`` using provided value and formatter.
	public static func string<Value>(
		from value: Value,
		formatter: @escaping (Value) -> String
	) -> Self {
		.init(formatter(value))
	}

	/// Create instance of localized ``DisplayableString`` using
	/// provided localization string key with optional arguments.
	/// String localization is achieved by using ``NSLocalizedString``.
	///
	/// - Parameters:
	///   - stringLocalizationKey: Localization key used to resolve string.
	///   - bundle: Bundle containing localized string for provided key.
	///   - tableName: Name of localization table. Default is none.
	///   - formatArguments: Arguments used to prepare final string
	///   treating resolved, localized string as a format.
	/// - Returns: Instance of localized ``DisplayableString`` using provided parameters.
	public static func localized(
		_ stringLocalizationKey: LocalizationKey,
		bundle: Bundle,
		tableName: String? = .none,
		formatArguments: CVarArg...
	) -> Self {
		if formatArguments.isEmpty {
			return .init(
				NSLocalizedString(
					stringLocalizationKey.rawValue,
					tableName: tableName,
					bundle: bundle,
					comment: ""
				)
			)
		}
		else {
			return .init(
				String(
					format: NSLocalizedString(
						stringLocalizationKey.rawValue,
						tableName: tableName,
						bundle: bundle,
						comment: ""
					),
					formatArguments
				)
			)
		}
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension DisplayableString: CustomStringConvertible {

	public var description: String {
		self.resolved
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension DisplayableString: CustomDebugStringConvertible {

	public var debugDescription: String {
		self.resolved
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension DisplayableString: CustomLeafReflectable {

	public var customMirror: Mirror {
		.init(
			self,
			children: [],
			displayStyle: .none
		)
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension DisplayableString: ExpressibleByStringInterpolation {

	public init(
		stringLiteral: String
	) {
		self.init(stringLiteral)
	}

	public init(
		stringInterpolation: StringInterpolation
	) {
		self.init(stringInterpolation.resolved())
	}
}

extension DisplayableString {

	/// Represents a string literal with interpolations.
	///
	/// Do not create an instance of this type directly.
	/// It is used by the compiler when you create
	/// a ``DisplayableString`` using string interpolation.
	///
	/// You can extend it with custom interpolation by defining
	/// ` mutating func appendInterpolation(args...)` methods
	/// in the extension of``StringInterpolation``.
	///
	/// See ``StringInterpolationProtocol`` for details.
	public struct StringInterpolation: StringInterpolationProtocol {

		private var parts: Array<() -> String>

		// swift-format-ignore: ValidateDocumentationComments
		/// Create new interpolation with predefined capacity.
		///
		/// Do not call this initializer directly. It is used by the compiler when
		/// interpreting string interpolations.
		public init(
			literalCapacity _: Int,
			interpolationCount _: Int
		) {
			self.parts = .init()
		}

		fileprivate func resolved() -> String {
			self.parts
				.reduce(
					into: "",
					{ result, part in
						result.append(part())
					}
				)
		}

		/// Append string literal.
		///
		/// - Parameter literal: Literal string value that will be appended.
		public mutating func appendLiteral(
			_ literal: String
		) {
			self.parts
				.append(
					always(literal)
				)
		}

		/// Append any value converted to its string representation.
		///
		/// - Parameter any: Any value that will be converted to a string.
		public mutating func appendInterpolation<Value>(
			_ any: Value
		) {
			self.parts
				.append(
					always(
						// fallback to stdlib interpolation
						// since it is using publicly inaccessible methods for
						// providing valid conversions for any type
						"\(any)"
					)
				)

		}

		/// Append formatted string.
		///
		/// - Parameters:
		///   - format: String used as a format for provided arguments.
		///   - head: First argument used to prepare final string.
		///   - tail: Rest of argument used to prepare final string.
		public mutating func appendInterpolation(
			format: String,
			arguments head: CVarArg,
			_ tail: CVarArg...
		) {
			self.parts
				.append(
					always(
						String(
							format: format,
							[head] + tail
						)
					)
				)
		}

		/// Append any value with given formatter.
		///
		/// - Parameters:
		///   - value: Value converted to a String using provided formatter.
		///   - formatter: Function used to convert provided value
		///   to a String.
		public mutating func appendInterpolation<Value>(
			_ value: Value,
			formatter: @escaping (Value) -> String
		) {
			self.parts
				.append(
					always(formatter(value))
				)
		}

		/// Append localized string with optional formatting.
		///
		/// - Parameters:
		///   - stringLocalizationKey: Localization key used to resolve string.
		///   - bundle: Bundle containing localized string for provided key.
		///   - tableName: Name of localization table. Default is none.
		///   - formatArguments: Arguments used to prepare final string
		///   treating resolved, localized string as a format.
		public mutating func appendInterpolation(
			localized stringLocalizationKey: LocalizationKey,
			bundle: Bundle,
			table tableName: String? = .none,
			formatArguments: CVarArg...
		) {
			if formatArguments.isEmpty {
				self.parts
					.append(
						always(
							NSLocalizedString(
								stringLocalizationKey.rawValue,
								tableName: tableName,
								bundle: bundle,
								comment: ""
							)
						)
					)
			}
			else {
				self.parts
					.append(
						always(
							String(
								format: NSLocalizedString(
									stringLocalizationKey.rawValue,
									tableName: tableName,
									bundle: bundle,
									comment: ""
								),
								formatArguments
							)
						)
					)
			}
		}
	}
}

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
extension DisplayableString: Hashable {

	public static func == (
		_ lhs: DisplayableString,
		_ rhs: DisplayableString
	) -> Bool {
		lhs.resolved == rhs.resolved
	}

	public func hash(
		into hasher: inout Hasher
	) {
		hasher.combine(self.resolved)
	}
}
