// swift-tools-version: 5.10
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
        .library(name: "DevToolImagePicker", targets: ["DevToolImagePicker"])
    ],
    dependencies: [
        .package(url: "https://github.com/alibaba/HandyJSON.git", from: "5.0.2")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DevToolCore",
            dependencies: [
                .product(name: "HandyJSON", package: "HandyJSON")
            ]
        ),
        .testTarget(
            name: "DevToolCoreTests",
            dependencies: ["DevToolCore"]
        ),

        .target(
            name: "DevToolFetch",
            dependencies: [
                .product(name: "HandyJSON", package: "HandyJSON")
            ]
        ),
        .target(name: "DevToolSwiftUIView"),
        .target(name: "DevToolImagePicker")
    ]
)
