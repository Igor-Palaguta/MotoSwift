import Foundation
import PathKit
import XCTest

extension XCTestCase {
    func url(forResource resource: String, ofType type: String) -> URL {
        #if SWIFT_PACKAGE
        let relativePath = "Tests/MotoSwiftFrameworkTests/Resources/\(resource).\(type)"
        return URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
            .appendingPathComponent(relativePath)
        #else
        return Bundle(for: Self.self).url(forResource: resource, withExtension: type)!
        #endif
    }

    func path(forResource resource: String, ofType type: String) -> Path {
        return Path(url(forResource: resource, ofType: type).path)
    }
}
