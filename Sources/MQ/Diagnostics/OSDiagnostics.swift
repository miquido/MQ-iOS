import OSLog

import class Foundation.NSProcessInfo

#if os(iOS)
import class UIKit.UIDevice
#endif

/// Application diagnostics.
///
/// ``OSDiagnostics`` is a diagnostics center
/// for the application. It allows gathering
/// system informations and logs.
public struct OSDiagnostics {

	public static let shared: Self = .init()

	// Basic info about the device.
	public let device: String
	// Basic info about the system.
	public let system: String
	// Basic info about the application.
	public let application: String
	// Application bundle indentifier if any.
	public let bundleIdentifier: String?
	@usableFromInline internal let logger: Logger

	@usableFromInline internal init() {
		#if os(iOS)
		self.device = UIDevice.current.model
		#elseif os(watchOS)
		self.device = "Apple Watch"
		#elseif os(tvOS)
		self.device = "Apple TV"
		#else
		self.device = "Mac"
		#endif
		self.system = ProcessInfo.processInfo.operatingSystemVersionString

		let infoDictionary: Dictionary<String, Any> = Bundle.main.infoDictionary ?? .init()
		self.application =
			"\(infoDictionary["CFBundleName"] as? String ?? "Application") \(infoDictionary["CFBundleShortVersionString"] as? String ?? "?.?.?")"
		self.bundleIdentifier = infoDictionary["CFBundleIdentifier"] as? String

		self.logger = .init(
			subsystem: (self.bundleIdentifier ?? "com.miquido") + ".diagnostics",
			category: "diagnostic"
		)
	}
}

extension OSDiagnostics: @unchecked Sendable {}

extension OSDiagnostics {

	/// Log a message.
	///
	/// Send a message to `info` log.
	///
	/// - Note: Message can be visible in production builds.
	///
	/// - Parameter message: Message to be logged.
	@_transparent @inline(__always)
	@Sendable public func log(
		_ message: StaticString
	) {
		self.logger.info("\(message, privacy: .public)")
	}

	/// Log an error.
	///
	/// Use `debug` log or ``print`` to log informations
	/// about the error.
	///
	/// - Note: Error details should not be visible in
	/// production builds (using OSLog `privacy: .public` with
	/// CustomStringConvertible.description to provide message in
	/// release build).
	///
	/// - Parameter message: Message to be logged.
	@_transparent @inline(__always)
	@Sendable public func log(
		_ error: TheError
	) {
		#if DEBUG
		self.logger.error("ERROR:\(error.debugDescription, privacy: .public)")
		#else
		self.logger.error("ERROR:\n\(error.description, privacy: .public)")
		#endif
	}

	/// Log a debug message.
	///
	/// Use ``print`` to log any message in debug builds.
	/// It has no effect on release builds.
	///
	/// - Parameter something: Something to be logged.
	@_transparent @inline(__always)
	@Sendable public func log<Something>(
		debug something: Something
	) {
		#if DEBUG
		print(
			(something as? CustomDebugStringConvertible)?.debugDescription
			?? something
		)
		#endif
	}

	/// Gather diagnostics informations.
	///
	/// Diagnostics informations contains all available
	/// diagnostics data and logs. Each diagnostic element
	/// and log is separate element in result array.
	///
	/// Parameters:
	///  - timeInterval: Time interval in seconds used to fetch logs data.
	///  Provided logs will be no older that requested. Default is one hour.
	///  - dateFormat: Date format used to format dates in logs.
	///  Defaults is "YYYY-MM-dd HH:mm:ss"
	///  - dateOffsetFromGMT: Time zone offset in seconds used to format dates in logs.
	///  Default is current system time zone.
	/// - Returns: Diagnostics informations array.
	@Sendable public func diagnosticsInfo(
		timeInterval: TimeInterval = 60 * 60,  // one hour
		dateFormat: String = "YYYY-MM-dd HH:mm:ss",
		dateOffsetFromGMT: Int = TimeZone.current.secondsFromGMT()
	) -> Array<String> {
		let environmentInfo: String = "\(self.device) OS \(self.system) \(self.application)"

		if #available(iOS 15.0, macOS 12.0, watchOS 8.0, tvOS 15.0, *) {
			do {
				let logStore: OSLogStore = try .init(scope: .currentProcessIdentifier)
				let dateFormatter: DateFormatter = .init()
				dateFormatter.timeZone = .init(secondsFromGMT: dateOffsetFromGMT)
				dateFormatter.dateFormat = dateFormat
				return try [environmentInfo]
					+ logStore
					.getEntries(
						at:
							logStore
							.position(
								date: Date(timeIntervalSinceNow: -timeInterval)
							),
						matching: NSPredicate(
							format: "category == %@",
							argumentArray: ["diagnostic"]
						)
					)
					.map { logEntry in
						"[\(dateFormatter.string(from: logEntry.date))] \(logEntry.composedMessage)"
					}
			}
			catch {
				return [
					environmentInfo,
					"Logs are not available",
				]
			}
		}
		else {
			return [
				environmentInfo,
				"Logs are not available",
			]
		}
	}
}
