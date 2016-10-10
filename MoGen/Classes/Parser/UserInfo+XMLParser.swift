import Foundation
import SWXMLHash

extension XMLIndexer {
   func userInfo() throws -> [String: String] {
      var userInfo: [String: String] = [:]
      for entryNode in self["userInfo"][0].children {
         guard let element = entryNode.element else {
            throw XMLParseError()
         }

         let key: String = try element.value(ofAttribute: "key")
         let value: String = try element.value(ofAttribute: "value")
         userInfo[key] = value
      }

      return userInfo
   }
}
