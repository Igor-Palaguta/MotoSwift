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
      .Package(url: "https://github.com/kylef/Stencil.git", majorVersion: 0, minor: 6),
      .Package(url: "https://github.com/kylef/Commander.git", majorVersion: 0, minor: 5),
      .Package(url: "https://github.com/drmohundro/SWXMLHash.git", majorVersion: 3, minor: 0),
      // https://github.com/apple/swift-package-manager/pull/597
      .Package(url: "https://github.com/kylef/Spectre", majorVersion: 0, minor: 7),
      ]
)
