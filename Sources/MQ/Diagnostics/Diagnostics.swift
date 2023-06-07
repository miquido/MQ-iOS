import OSLog

import class Foundation.NSProcessInfo

#if os(iOS)
import class UIKit.UIDevice
#endif

/// Application diagnostics.
///
/// ``Diagnostics`` is a diagnostics center
/// for the application. It allows gathering
/// system informations and logs.
public struct Diagnostics {

	/// Shared instance of ``Diagnostics``.
	///
	/// ``shared`` can be be used to access logs
	/// and environment info from the application itself.
	/// In order to disable it call ``disable`` function.
	/// Diagnostics will be disabled automatically during unit tests.
	public static let shared: Self = {
		if Self.enabled {
			return .live()
		}
		else {
			return .disabled()
		}
	}()

	// Basic info about the device.
	public let device: String
	// Basic info about the system.
	public let system: String
	// Basic info about the application.
	public let application: String
	// Application bundle indentifier if any.
	public let bundleIdentifier: String?
	// Default logger
	public let logger: Logger

	private init(
		device: String,
		system: String,
		application: String,
		bundleIdentifier: String?,
		logger: Logger
	) {
		self.device = device
		self.system = system
		self.application = application
		self.bundleIdentifier = bundleIdentifier
		self.logger = logger
	}
}

extension Diagnostics: @unchecked Sendable {}

extension Diagnostics {

	/// Disable diagnostics.
	///
	/// When called all of ``Diagnostics`` details
	/// and functionalities will be disabled.
	///
	/// - Note: You can't disable diagnostics after using it.
	/// Disabling diagnostics it is not thread safe.
	public static func disable() {
		Self.enabled = false
	}

	private static var enabled: Bool = {
		// Disabled automatically for XCTest
		!(Bundle.main.infoDictionary?["CFBundleName"] as? String == "xctest"
			|| ProcessInfo.processInfo.environment.keys.contains("XCTestBundlePath")
			|| ProcessInfo.processInfo.environment.keys.contains("XCTestSessionIdentifier"))
	}()

	/// Create a new instance of logger with given category.
	///
	/// Creating multiple loggers can be useful in order
	/// to provide more granular system diagnostics.
	/// Created loggers are not cached nor reused, you have to manage them
	/// manually after creating.
	///
	/// Returned logger will be disabled if Diagnostics itself is disabled.
	///
	/// - Parameter category: Name of the category used to identify this logger.
	/// - Returns: New instance of logger with given category and subsystem from
	/// bundle indentifier of shared diagnostics.
	/// Logger will be disabled if Diagnostics is disabled.
	public static func logger(
		category: String
	) -> Logger {
		if Self.enabled {
			return .init(
				subsystem: Self.shared.bundleIdentifier ?? "com.miquido.diagnostics",
				category: category
			)
		}
		else {
			return .init(.disabled)
		}
	}

	/// Default diagnostics logger.
	///
	/// Access current shared logger.
	/// Shared logger category is "diagnostics".
	public static var logger: Logger {
		Self.shared.logger
	}

	private static func live() -> Self {
		#if os(iOS)
		let device: String = UIDevice.current.model
		#elseif os(watchOS)
		let device: String = "Apple Watch"
		#elseif os(tvOS)
		let device: String = "Apple TV"
		#else
		let device: String = "Mac"
		#endif
		let system: String = ProcessInfo.processInfo.operatingSystemVersionString

		let infoDictionary: Dictionary<String, Any> = Bundle.main.infoDictionary ?? .init()
		let application: String =
			"\(infoDictionary["CFBundleName"] as? String ?? "Application") \(infoDictionary["CFBundleShortVersionString"] as? String ?? "?.?.?")"
		let bundleIdentifier: String? = infoDictionary["CFBundleIdentifier"] as? String

		let logger: Logger = .init(
			subsystem: bundleIdentifier ?? "com.miquido.diagnostics",
			category: "diagnostics"
		)

		return .init(
			device: device,
			system: system,
			application: application,
			bundleIdentifier: bundleIdentifier,
			logger: logger
		)
	}

	private static func disabled() -> Self {
		return .init(
			device: "N/A",
			system: "N/A",
			application: "N/A",
			bundleIdentifier: .none,
			logger: .init(.disabled)
		)
	}
}

extension Diagnostics {

	/// Gather diagnostics informations.
	///
	/// Diagnostics informations contains all available
	/// diagnostics data and logs. Each diagnostic element
	/// and log is separate element in result array.
	/// Result will be empty if Diagnostics is disabled.
	///
	/// Parameters:
	///  - category: Name of the category used to filter logs output.
	///  If none provided all categories will be included. Default is none.
	///  - timeInterval: Time interval in seconds used to fetch logs data.
	///  Provided logs will be no older that requested. Default is one hour.
	///  - dateFormat: Date format used to format dates in logs.
	///  Defaults is "YYYY-MM-dd HH:mm:ss"
	///  - dateOffsetFromGMT: Time zone offset in seconds used to format dates in logs.
	///  Default is current system time zone.
	/// - Returns: Diagnostics informations array.
	@Sendable public func diagnosticsInfo(
		category: String? = .none,
		timeInterval: TimeInterval = 60 * 60,  // one hour
		dateFormat: String = "YYYY-MM-dd HH:mm:ss",
		dateOffsetFromGMT: Int = TimeZone.current.secondsFromGMT()
	) -> Array<String> {
		if Self.enabled {
			let subsystem: String = Self.shared.bundleIdentifier ?? "com.miquido.diagnostics"
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
							matching: category.map { (category: String) in
								NSPredicate(
									format: "subsystem == %@ AND category == %@",
									argumentArray: [subsystem, category]
								)
							}
								?? NSPredicate(
									format: "subsystem == %@",
									argumentArray: [subsystem]
								)
						)
						.map { (logEntry: OSLogEntry) in
							if let entryWithPayload: OSLogEntryWithPayload = logEntry as? OSLogEntryWithPayload {
								return
									"[\(dateFormatter.string(from: logEntry.date))] [\(entryWithPayload.category)] \(logEntry.composedMessage)"
							}
							else {
								return "[\(dateFormatter.string(from: logEntry.date))] \(logEntry.composedMessage)"
							}
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
		else {
			return [
				"Diagnostics is disabled"
			]
		}
	}
}
