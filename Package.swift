import PackageDescription

let package = Package(
  name: "MotoSwift",
  targets: [
    Target(name: "MotoSwiftFramework"),
    Target(name: "motoswift",
      dependencies: [
        .Target(name: "MotoSwiftFramework")
      ]),
  ],
  dependencies: [
    .Package(url: "https://github.com/drmohundro/SWXMLHash.git", majorVersion: 3, minor: 0)
  ]
)