// Based on https://www.pointfree.co/blog/posts/70-unobtrusive-runtime-warnings-for-libraries

#if DEBUG
	import os

	private struct RuntimeWarningHandle {

		private let dso: UnsafeMutableRawPointer
		private let log: OSLog

		fileprivate init(
			dso: UnsafeMutableRawPointer,
			log: OSLog
		) {
			self.dso = dso
			self.log = log
		}

		@_transparent
		@inline(__always)
		fileprivate func runtimeWarning(
			_ message: () -> StaticString,
			_ args: () -> Array<CVarArg>
		) {
			unsafeBitCast(
				os_log as (OSLogType, UnsafeRawPointer, OSLog, StaticString, CVarArg...) -> Void,
				to: ((OSLogType, UnsafeRawPointer, OSLog, StaticString, Array<CVarArg>) -> Void).self
			)(.fault, self.dso, self.log, message(), args())
		}
	}

	private let handle: RuntimeWarningHandle = .init(
		dso: { () -> UnsafeMutableRawPointer in
			let count: UInt32 = _dyld_image_count()
			for index: UInt32 in 0..<count {
				if let cName: UnsafePointer<CChar> = _dyld_get_image_name(index) {
					let name: String = .init(cString: cName)
					if name.hasSuffix("/SwiftUI") {
						if let header: UnsafePointer<mach_header> = _dyld_get_image_header(index) {
							return UnsafeMutableRawPointer(
								mutating: UnsafeRawPointer(header)
							)
						}
						else {
							continue
						}
					}
					else {
						continue
					}
				}
				else {
					continue
				}
			}
			return UnsafeMutableRawPointer(
				mutating: #dsohandle
			)
		}(),
		log: .init(
			subsystem: "com.apple.runtime-issues",
			category: "MQ-RuntimeWarning"
		)
	)
#endif

@_transparent
@inline(__always)
internal func runtimeWarning(
	_ message: @autoclosure () -> StaticString,
	_ args: @autoclosure () -> Array<CVarArg> = .init()
) {
	#if DEBUG
		handle.runtimeWarning(message, args)
	#endif
}
