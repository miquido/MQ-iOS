extension DecodingError: TheErrorConvertible {

	public func convertToTheError(
		file: StaticString,
		line: UInt
	) -> TheError {
		switch self {
		case .valueNotFound(let type, let context):
			return
				ValueNotFound
				.error(
					message: "Trying to decode missing value",
					type: type,
					file: file,
					line: line
				)
				.with(context, for: "decoding context")

		case .dataCorrupted(let context):
			return
				DataCorrupted
				.error(
					message: "Trying to decode corrupted data",
					file: file,
					line: line
				)
				.with(context, for: "decoding context")

		case .typeMismatch(let type, let context):
			return
				TypeMismatch
				.error(
					message: "Trying to decode invalid value",
					type: type,
					file: file,
					line: line
				)
				.with(context, for: "decoding context")

		case .keyNotFound(let key, let context):
			return
				KeyNotFound
				.error(
					message: "Trying to decode missing value",
					key: key,
					file: file,
					line: line
				)
				.with(context, for: "decoding context")

		@unknown case _:
			return
				Unexpected
				.error(
					message: "Unknown decoding error",
					underlyingError: self,
					file: file,
					line: line
				)
		}
	}
}
