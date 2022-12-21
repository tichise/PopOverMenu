// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "PopOverMenu",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "PopOverMenu", targets: ["PopOverMenu"])
    ],
    dependencies: [],
    targets: [
        .target(name: "PopOverMenu", dependencies: [], path: "Sources"),
        
    ],
    swiftLanguageVersions: [.v5]
)
