// swift-tools-version:5.1
import PackageDescription

let package = Package(
	name: "Time",
	products: [
		.library(
			name: "Time",
			targets: ["Time"]
		),
	],
	targets: [
		.target(
			name: "Time"
		),
        .testTarget(name: "TimeTests", dependencies: ["Time"]),
	]
)
