// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "dep-test",
    platforms: [.macOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "dep-test",
            targets: ["dep-test"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.6.3"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "dep-test", dependencies: [
            .product(name: "Dependencies", package: "swift-dependencies"),
        ]),
        .testTarget(
            name: "dep-testTests",
            dependencies: ["dep-test"]
        ),
    ]
)
