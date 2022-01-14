import Darwin

/// Check if debugger is attached to the process.
///
/// Verify if current process has attached debugger.
///
/// - Returns: `true` if if debugger is attached to the process, `false` otherwise.
@inlinable @inline(__always)
public func isDebuggerAttached() -> Bool {
	var name: Array<Int32> = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
	var info: kinfo_proc = .init()
	var info_size: Int = MemoryLayout<kinfo_proc>.size

	return sysctl(&name, 4, &info, &info_size, nil, 0) != -1
		&& info.kp_proc.p_flag & P_TRACED != 0
}
