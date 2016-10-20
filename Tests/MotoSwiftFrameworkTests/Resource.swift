import Foundation

func url(forResource resource: String, ofType type: String) -> URL {
   #if SWIFT_PACKAGE
      let relativePath = "Tests/MotoSwiftFrameworkTests/Resources/\(resource).\(type)"
      return URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
         .appendingPathComponent(relativePath)
   #else
      return Bundle(for: MotoSwiftTests.self).url(forResource: resource, withExtension: type)!
   #endif
}
