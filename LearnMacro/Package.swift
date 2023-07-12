// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "LearnMacro",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "LearnMacro",
            targets: ["LearnMacro"]
        ),
        .executable(
            name: "LearnMacroClient",
            targets: ["LearnMacroClient"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-syntax.git",
            from: "509.0.0-swift-5.9-DEVELOPMENT-SNAPSHOT-2023-04-25-b"
        ),
    ],
    targets: [
        .macro(
            name: "LearnMacroMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        .target(
            name: "LearnMacro",
            dependencies: ["LearnMacroMacros"]
        ),
        .executableTarget(
            name: "LearnMacroClient",
            dependencies: ["LearnMacro"]
        ),
        .testTarget(
            name: "LearnMacroTests",
            dependencies: [
                "LearnMacroMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        ),
    ]
)
