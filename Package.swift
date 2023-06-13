// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "HexColorCodeMacros",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .macCatalyst(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "HexColorCodeMacros",
            targets: ["HexColorCodeMacros"]
        ),
        .executable(
            name: "_HexColorCodeMacrosGen",
            targets: ["_HexColorCodeMacrosGen"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", branch: "main"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "HexColorCodeMacros",
            dependencies: [
                "HexColorCodeMacrosPlugin"
            ]
        ),
        .macro(
            name: "HexColorCodeMacrosPlugin",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
                .product(name: "SwiftParserDiagnostics", package: "swift-syntax"),
            ]
        ),
        .target(
            name: "_HexColorCodeMacrosGenCore"
        ),
        .executableTarget(
            name: "_HexColorCodeMacrosGen",
            dependencies: [
                "_HexColorCodeMacrosGenCore",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .testTarget(
            name: "HexColorCodeMacrosTests",
            dependencies: ["HexColorCodeMacros"]
        ),
    ]
)
