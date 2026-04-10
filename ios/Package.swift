// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "BesitosOfferwall",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "BesitosOfferwall",
            targets: ["BesitosOfferwall"]
        ),
    ],
    targets: [
        .target(
            name: "BesitosOfferwall",
            path: "Sources/BesitosOfferwall"
        ),
    ]
)
