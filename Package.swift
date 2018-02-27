import PackageDescription

let package = Package(
   name: "MotoSwift",
   targets: [
      Target(name: "MotoSwiftFramework"),
      Target(name: "motoswift",
             dependencies: [
               .Target(name: "MotoSwiftFramework"),
               ]),
      ],
   dependencies: [
      .Package(url: "https://github.com/SwiftGen/StencilSwiftKit.git", majorVersion: 2, minor: 3),
      .Package(url: "https://github.com/kylef/Commander.git", majorVersion: 0, minor: 6),
      .Package(url: "https://github.com/drmohundro/SWXMLHash.git", majorVersion: 4, minor: 0),
      // https://github.com/apple/swift-package-manager/pull/597
      //.Package(url: "https://github.com/kylef/Spectre", majorVersion: 0, minor: 7),
      ]
)

package.exclude = ["Tests/MotoSwiftFrameworkTests/Resources"]
