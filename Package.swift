// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Keel",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(name: "Keel", type: .dynamic, targets: ["Keel"])
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.0.0"),
        .package(url: "https://source.skip.tools/skip-ui.git", from: "1.0.0"),
        .package(url: "https://source.skip.tools/skip-model.git", from: "1.0.0"),
        .package(url: "https://github.com/RevenueCat/purchases-ios.git", from: "5.0.0"),
    ],
    targets: [
        .target(
            name: "Keel",
            dependencies: [
                .product(name: "SkipUI", package: "skip-ui"),
                .product(name: "SkipModel", package: "skip-model"),
                .product(name: "RevenueCat", package: "purchases-ios"),
            ],
            resources: [
                .process("Resources")
            ],
            plugins: [.plugin(name: "skipstone", package: "skip")]
        ),
        .testTarget(
            name: "KeelTests",
            dependencies: ["Keel"]
        ),
        .testTarget(
            name: "KeelUITests",
            dependencies: ["Keel"]
        ),
    ]
)
