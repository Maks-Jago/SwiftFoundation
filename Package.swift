// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftFoundation",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "SwiftFoundation",
            targets: ["SwiftFoundation"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftFoundation",
            dependencies: [],
            path: "Sources"),

        .testTarget(
            name: "SwiftFoundationTests",
            dependencies: ["SwiftFoundation"],
            path: "Tests"),
    ]
)
