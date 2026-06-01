// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "NoctUI",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "NoctUI",
            targets: ["NoctUI"]
        )
    ],
    targets: [
        .target(
            name: "NoctUI",
            path: "NoctUI",
            exclude: [
                "AppTheme",
                "Assets.xcassets",
                "NoctUIApp.swift",
                "Playground",
                "RootView.swift",
                "SharedUI",
                "Utils"
            ]
        )
    ]
)
