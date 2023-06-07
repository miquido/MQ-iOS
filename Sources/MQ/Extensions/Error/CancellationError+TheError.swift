public typealias Cancelled = CancellationError

extension CancellationError: TheError {

	public static func error() -> Self {
		.init()
	}

	public var context: SourceCodeContext {
		get {
			.context(
				message: "Cancelled",
				// can't get actual source of cancellation
				// using this location instead
				file: #fileID,
				line: #line
			)
		}
		set {
			// cancellation can't hold extra things...
			Unimplemented
				.error(
					message: "CancellationError can't hold additional context information."
				)
				.asRuntimeWarning(
					message: "CancellationError context update ignored."
				)
		}
	}
}
