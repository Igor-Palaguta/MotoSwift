import Foundation
import SWXMLHash

extension XMLIndexer {
   func userInfo() throws -> [String: String] {
      let keysAndValues: [(String, String)] = try self["userInfo"][0].children.map {
         try ($0.value(ofAttribute: "key"), $0.value(ofAttribute: "value"))
      }

      return Dictionary(keysAndValues) { first, _ in first }
   }
}
