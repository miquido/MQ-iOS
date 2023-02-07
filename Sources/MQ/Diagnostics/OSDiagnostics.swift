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

	private let deviceModel: String
	private let systemVersion: String
	private let appName: String
	private let appVersion: String
	private let appBundleIdentifier: String
	@usableFromInline internal let logger: Logger

	/// Create instance of ``OSDiagnostics``
	/// using OSLog framework to provide logging.
	public init() {
		#if os(iOS)
			self.deviceModel = UIDevice.current.model
		#elseif os(watchOS)
			self.deviceModel = "Apple Watch"
		#elseif os(tvOS)
			self.deviceModel = "Apple TV"
		#else
			self.deviceModel = "Mac"
		#endif
		self.systemVersion = ProcessInfo.processInfo.operatingSystemVersionString

		let infoDictionary: Dictionary<String, Any> = Bundle.main.infoDictionary ?? .init()
		self.appName = infoDictionary["CFBundleName"] as? String ?? "App"
		self.appVersion = infoDictionary["CFBundleShortVersionString"] as? String ?? "?.?.?"
		self.appBundleIdentifier = infoDictionary["CFBundleIdentifier"] as? String ?? "com.miquido.unknown"

		self.logger = .init(
			subsystem: self.appBundleIdentifier + ".diagnostics",
			category: "diagnostic"
		)
	}
}

extension OSDiagnostics {

	/// Get basic info about the application.
	///
	/// Informations about running application
	/// name and version.
	///
	/// - Returns: Basic app info.
	@Sendable public func appInfo() -> String {
		"\(self.appName) \(self.appVersion)"
	}

	/// Get basic info about the device.
	///
	/// Informations about current device
	/// model and system version.
	///
	/// - Returns: Basic app info.
	@Sendable public func deviceInfo() -> String {
		"\(self.deviceModel) \(self.systemVersion)"
	}

	/// Log a message.
	///
	/// Send a message to `info` log.
	///
	/// - Note: Message can be visible in production builds.
	///
	/// - Parameter message: Message to be logged.
	@_transparent
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
	/// production builds (using OSLog `privacy: auto`).
	///
	/// - Parameter message: Message to be logged.
	@_transparent
	@Sendable public func log(
		_ error: TheError
	) {
		#if DEBUG
			print(error.debugDescription)
		#else
			self.logger.error("\(error.description, privacy: .auto)")
		#endif
	}

	/// Log a debug message.
	///
	/// Use ``print`` to log any message in debug builds.
	/// about the error.
	/// It has no effect on release builds.
	///
	/// - Parameter message: Message to be logged.
	@_transparent
	@Sendable public func log(
		debug message: String
	) {
		#if DEBUG
			print(message)
		#endif
	}

	/// Gather diagnostics informations.
	///
	/// Diagnostics informations contains all available
	/// diagnostics data and logs. Each diagnostic element
	/// and log is separate element in result array.
	///
	/// - Returns: Diagnostics informations array.
	@Sendable public func diagnosticsInfo() -> Array<String> {
		let environmentInfo: String = "\(self.appName) \(self.appVersion) \(self.deviceModel) iOS \(self.systemVersion)"

		if #available(iOS 15.0, macOS 12.0, watchOS 8.0, tvOS 15.0, *) {
			do {
				let logStore: OSLogStore = try .init(scope: .currentProcessIdentifier)
				let dateFormatter: DateFormatter = .init()
				dateFormatter.timeZone = .init(secondsFromGMT: 0)
				dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
				return try [environmentInfo]
					+ logStore
					.getEntries(
						at:
							logStore
							.position(  // last hour
								date: Date(timeIntervalSinceNow: -60 * 60)
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
