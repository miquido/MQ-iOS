import Darwin

/// Trigger breakpoint on debug builds.
///
/// Trigger breakpoint when debugger is attached in debug build.
/// Does nothing on non debug builds or when debugger is not attached.
///
/// - Parameter message: Message to be printed on stderr when hitting breakpoint.
/// Default is empty.
@_transparent
@Sendable public func breakpoint(
	_ message: @autoclosure @Sendable () -> String = .init()
) {
	#if DEBUG
		guard isDebuggerAttached()
		else { return }  // skip when debugger is not attached

		fputs(message(), stderr)
		raise(SIGTRAP)
	#endif
}
