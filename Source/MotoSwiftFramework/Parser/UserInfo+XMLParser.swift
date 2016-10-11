import Foundation
import SWXMLHash

extension XMLIndexer {
   func userInfo() throws -> [String: String] {
      var userInfo: [String: String] = [:]
      for entryNode in self["userInfo"][0].children {
         let key: String = try entryNode.value(ofAttribute: "key")
         let value: String = try entryNode.value(ofAttribute: "value")
         userInfo[key] = value
      }

      return userInfo
   }
}
