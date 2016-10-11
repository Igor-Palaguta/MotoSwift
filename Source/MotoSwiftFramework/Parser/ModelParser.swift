import Foundation
import SWXMLHash

public final class ModelParser {

   public init() {
   }

   public func parseModel(fromPath path: String) throws -> Model {
      let path = URL(fileURLWithPath: try currentVersion(forModelPath: path), isDirectory: true)
         .appendingPathComponent("contents")
         .path

      let content = try String(contentsOfFile: path)
      let xml = SWXMLHash.parse(content)
      let entities: [Entity] = try xml["model"]["entity"].map { try Entity(xml: $0) }
      return Model(entities)
   }

   private func currentVersion(forModelPath modelPath: String) throws -> String {
      let url = URL(fileURLWithPath: modelPath, isDirectory: true)
      switch url.pathExtension {
      case "xcdatamodel":
         return modelPath
      case "xcdatamodeld":
         let currentVersionFile = url.appendingPathComponent(".xccurrentversion").path
         guard FileManager.default.fileExists(atPath: currentVersionFile) else {
            return url
               .appendingPathComponent(url.lastPathComponent)
               .deletingPathExtension()
               .appendingPathExtension("xcdatamodel")
               .path
         }
         guard let plist = NSDictionary(contentsOfFile: currentVersionFile),
            let versionFile = plist["_XCCurrentVersionName"] as? String else {
               throw MotoSwiftError("_XCCurrentVersionName key is absent in: '\(currentVersionFile)'")
         }
         return url.appendingPathComponent(versionFile).path
      default:
         throw MotoSwiftError("Invalid model type: '\(modelPath)'")
      }
   }
}
