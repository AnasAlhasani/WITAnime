// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "WITAnime",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "WITAnime", targets: ["WITAnime"])
    ],
    dependencies: [
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.6.0"),
        .package(url: "https://github.com/pointfreeco/swift-tagged.git", from: "0.6.0")
    ],
    targets: [
        .target(name: "WITAnime", dependencies: [
            "SwiftSoup",
            .product(name: "Tagged", package: "swift-tagged")
        ]),
        .testTarget(name: "WiTAnimeTests", dependencies: ["WITAnime"])
    ]
)
