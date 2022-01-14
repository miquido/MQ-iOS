import Darwin

/// Trigger breakpoint on debug builds.
///
/// Trigger breakpoint when debugger is attached in debug build.
/// Does nothing on nondebug builds or when debugger is not attached.
///
/// - Parameter message: Message to be printed on stderr when hitting breakpoint.
/// Default is empty.
@inlinable @inline(__always)
public func breakpoint(
	_ message: @autoclosure () -> String = .init()
) {
	#if DEBUG
		guard isDebuggerAttached()
		else { return }  // skip when debugger is not attached

		fputs(message(), stderr)
		raise(SIGTRAP)
	#endif
}
