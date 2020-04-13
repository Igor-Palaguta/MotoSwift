import Foundation
import PathKit
import SWXMLHash

public final class ModelParser {

    public init() {}

    public func parseModel(at modelPath: Path) throws -> Model {
        let contentPath = try currentModelVersion(at: modelPath) + "contents"

        let content: String = try contentPath.read()
        let xml = SWXMLHash.parse(content)
        let entities = try xml["model"]["entity"].all.map { try Entity(xml: $0) }
        return Model(name: modelPath.lastComponentWithoutExtension, entities: entities)
    }

    private func currentModelVersion(at path: Path) throws -> Path {
        switch path.extension {
        case "xcdatamodel":
            return path
        case "xcdatamodeld":
            let versionFilePath = path + ".xccurrentversion"
            guard versionFilePath.exists else {
                return path + "\(path.lastComponentWithoutExtension).xcdatamodel"
            }
            let versionKey = "_XCCurrentVersionName"
            guard let plist = NSDictionary(contentsOfFile: String(describing: versionFilePath)),
                let versionFile = plist[versionKey] as? String else {
                throw AbsentPlistKey(key: versionKey, path: versionFilePath)
            }
            return path + versionFile
        default:
            throw InvalidModelType(path: path)
        }
    }
}

private struct AbsentPlistKey: Error, CustomStringConvertible {
    let key: String
    let path: Path

    var description: String {
        return "'\(key)' absent in \(path.string)"
    }
}

private struct InvalidModelType: Error, CustomStringConvertible {
    let path: Path

    var description: String {
        return "Invalid model type: '\(path)'"
    }
}
