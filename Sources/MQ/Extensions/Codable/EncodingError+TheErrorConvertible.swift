extension EncodingError: TheErrorConvertible {

	public func convertToTheError(
		file: StaticString,
		line: UInt
	) -> TheError {
		switch self {
		case .invalidValue(let value, let context):
			return
				InvalidValue
				.error(
					message: "Trying to encode invalid value",
					value: value,
					file: file,
					line: line
				)
				.with(context, for: "encoding context")

		@unknown case _:
			return
				Unexpected
				.error(
					message: "Unknown encoding error",
					underlyingError: self,
					file: file,
					line: line
				)
		}
	}
}
