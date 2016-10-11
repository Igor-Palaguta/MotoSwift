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
      //.Package(url: "https://github.com/Quick/Nimble", majorVersion: 5, minor: 0),
      //.Package(url: "https://github.com/Quick/Quick", majorVersion: 0, minor: 10),
      ]
)
