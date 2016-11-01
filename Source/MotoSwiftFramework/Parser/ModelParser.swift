import Foundation
import SWXMLHash
import PathKit

public final class ModelParser {

   public init() {
   }

   public func parseModel(fromPath path: Path) throws -> Model {
      let path = try currentVersion(forModelPath: path) + "contents"

      let content: String = try path.read()
      let xml = SWXMLHash.parse(content)
      let entities: [Entity] = try xml["model"]["entity"].map { try Entity(xml: $0) }
      return Model(entities)
   }

   private func currentVersion(forModelPath modelPath: Path) throws -> Path {
      switch modelPath.extension {
      case .some("xcdatamodel"):
         return modelPath
      case .some("xcdatamodeld"):
         let versionFilePath = modelPath + ".xccurrentversion"
         guard versionFilePath.exists else {
            return modelPath + "\(modelPath.lastComponentWithoutExtension).xcdatamodel"
         }
         let versionKey = "_XCCurrentVersionName"
         guard let plist = NSDictionary(contentsOfFile: String(describing: versionFilePath)),
            let versionFile = plist[versionKey] as? String else {
               throw MotoError.absentPlistKey(key: versionKey, plistPath: String(describing: versionFilePath))
         }
         return modelPath + versionFile
      default:
         throw MotoError.invalidModelType(String(describing: modelPath))
      }
   }
}
