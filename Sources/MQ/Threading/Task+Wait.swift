/// Method backing ``Task.wait`` implementation.
///
/// Default implementation is using ``Task.sleep``.
/// You can replace this implementation if needed.
///
/// - warning: If you replace this implementation you are responsible for its correctness.
///
/// - warning: Implementation exchange is not thread safe.
public var taskWaitingMethod: (_ nanoseconds: UInt64) async throws -> Void = { (nanoseconds: UInt64) in
	try await Task.sleep(nanoseconds: nanoseconds)
}

extension Task {

	/// Suspend current task execution for a given time.
	///
	/// This method is a replacement for ``Task.sleep`` allowing
	/// to exchange implementation. Main purpose of this is to
	/// allow skipping unnecessary waiting in unit tests.
	///
	/// Exact behaviour is determined by current ``taskWaitingMethod`` implementation.
	///
	/// - Parameter nanoseconds: Number of nanoseconds by which task
	/// will be suspended.
	/// - Throws: CancellationError in case of cancelling task. Exact details
	/// depend on current ``taskWaitingMethod`` implementation.
	@inlinable public static func wait(nanoseconds: UInt64) async throws {
		try await taskWaitingMethod(nanoseconds)
	}

	/// Suspend current task execution for a given time.
	///
	/// This method is a replacement for ``Task.sleep`` allowing
	/// to exchange implementation. Main purpose of this is to
	/// allow skipping unnecessary waiting in unit tests.
	///
	/// Exact behaviour is determined by current ``taskWaitingMethod`` implementation.
	///
	/// - Parameter seconds: Number of seconds by which task
	/// will be suspended.
	/// - Throws: CancellationError in case of cancelling task. Exact details
	/// depend on current ``taskWaitingMethod`` implementation.
	@inlinable public static func wait(seconds: UInt64) async throws {
		try await taskWaitingMethod(seconds * 1_000_000_000)
	}
}
