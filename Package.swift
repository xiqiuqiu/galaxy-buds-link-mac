// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "GalaxyBudsLink",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(name: "GalaxyBudsCore", targets: ["GalaxyBudsCore"]),
        .executable(name: "GalaxyBudsLinkMac", targets: ["GalaxyBudsLinkMac"])
    ],
    targets: [
        .target(
            name: "GalaxyBudsCore",
            path: "macOS/Sources/GalaxyBudsCore"
        ),
        .executableTarget(
            name: "GalaxyBudsLinkMac",
            dependencies: ["GalaxyBudsCore"],
            path: "macOS/Sources/GalaxyBudsLinkMac"
        ),
        .testTarget(
            name: "GalaxyBudsCoreTests",
            dependencies: ["GalaxyBudsCore"],
            path: "macOS/Tests/GalaxyBudsCoreTests"
        )
    ]
)
