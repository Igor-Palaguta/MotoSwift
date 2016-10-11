import Foundation
import SWXMLHash

extension Relationship {
   init(xml: XMLIndexer) throws {
      self.name = try xml.value(ofAttribute: "name")
      self.entityName = try xml.value(ofAttribute: "destinationEntity")
      self.isOptional = xml.value(ofAttribute: "optional") ?? false
      self.toMany = xml.value(ofAttribute: "toMany") ?? false
      self.isOrdered = xml.value(ofAttribute: "ordered") ?? false
      self.userInfo = try xml.userInfo()
   }
}
