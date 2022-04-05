// swift-tools-version:5.6
import PackageDescription

let package = Package(
	name: "MQ",
	platforms: [
		.iOS(.v14),
		.macOS(.v11),
		.macCatalyst(.v14),
		.tvOS(.v14),
		.watchOS(.v7),
	],
	products: [
		.library(
			name: "MQ",
			targets: [
				"MQ"
			]
		)
	],
	targets: [
		.target(
			name: "MQ"
		),
		.testTarget(
			name: "MQTests",
			dependencies: [
				"MQ"
			]
		),
	],
	swiftLanguageVersions: [.v5]
)
