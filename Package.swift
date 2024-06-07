// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DevTool",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "DevToolCore", targets: ["DevToolCore"]),
        .library(name: "DevToolFetch", targets: ["DevToolFetch"]),
        .library(name: "DevToolSwiftUIView", targets: ["DevToolSwiftUIView"]),
        .library(name: "DevToolImagePicker", targets: ["DevToolImagePicker"]),
        .library(name: "DevToolHandy", targets: ["DevToolHandy"])

    ],
    dependencies: [
        .package(url: "https://github.com/intsig171/SmartCodable.git", from: "3.4.5")
    ],
    targets: [
        //
        .target(
            name: "DevToolCore",
            dependencies: []
        ),
        //
        .testTarget(
            name: "DevToolCoreTests",
            dependencies: ["DevToolCore"]
        ),
        .target(
            name: "DevToolFetch",
            dependencies: [
                "DevToolCore",
                "SmartCodable"
            ]
        ),
        .target(name: "DevToolSwiftUIView"),
        .target(name: "DevToolImagePicker"),
        .target(
            name: "DevToolHandy",
            dependencies: [
                "DevToolCore",
                "SmartCodable"
            ]
        )
    ]
)
