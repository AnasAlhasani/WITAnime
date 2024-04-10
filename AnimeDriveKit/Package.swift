// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "AnimeDriveKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "AnimeDriveKit", targets: ["AnimeDriveKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.6.0"),
        .package(url: "https://github.com/pointfreeco/swift-tagged.git", from: "0.6.0")
    ],
    targets: [
        .target(name: "AnimeDriveKit", dependencies: [
            "SwiftSoup",
            .product(name: "Tagged", package: "swift-tagged")
        ]),
        .testTarget(name: "AnimeDriveKitTests", dependencies: ["AnimeDriveKit"])
    ]
)
