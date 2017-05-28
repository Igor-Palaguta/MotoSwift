import Foundation
import SWXMLHash
import PathKit

public final class ModelParser {

   public init() {
   }

   public func parseModel(at path: Path) throws -> Model {
      let path = try currentModelVersion(at: path) + "contents"

      let content: String = try path.read()
      let xml = SWXMLHash.parse(content)
      let entities: [Entity] = try xml["model"]["entity"].map { try Entity(xml: $0) }
      return Model(entities)
   }

   private func currentModelVersion(at path: Path) throws -> Path {
      switch path.extension {
      case .some("xcdatamodel"):
         return path
      case .some("xcdatamodeld"):
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

   public var description: String {
      return "Invalid model type: '\(path)'"
   }
}
