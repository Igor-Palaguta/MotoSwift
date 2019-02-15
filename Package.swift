// swift-tools-version:4.2
import PackageDescription

let package = Package(
   name: "MotoSwift",
   products: [
      .executable(name: "motoswift", targets: ["motoswift"]),
      .library(name: "MotoSwiftFramework", targets: ["MotoSwiftFramework"])
      ],
   dependencies: [
      .package(url: "https://github.com/SwiftGen/StencilSwiftKit.git", from: "2.7.0"),
      .package(url: "https://github.com/kylef/Commander.git", from: "0.8.0"),
      .package(url: "https://github.com/drmohundro/SWXMLHash.git", from: "4.7.0"),
      .package(url: "https://github.com/kylef/Spectre", from: "0.8.0")
      ],
   targets: [
      .target(name: "MotoSwiftFramework", dependencies: ["StencilSwiftKit", "SWXMLHash"]),
      .target(name: "motoswift", dependencies: ["MotoSwiftFramework", "Commander"]),
      .testTarget(
           name: "MotoSwiftFrameworkTests",
           dependencies: ["MotoSwiftFramework", "Spectre"]
      )
   ]
)
