import Foundation
import SWXMLHash

extension Entity {
   init(xml: XMLIndexer) throws {
      self.name = try xml.value(ofAttribute: "name")
      self.className = xml.value(ofAttribute: "representedClassName")

      self.attributes = try xml.children
         .compactMap { $0.element?.name == "attribute" ? try Attribute(xml: $0) : nil }

      self.relationships = try xml.children
         .compactMap { $0.element?.name == "relationship" ? try Relationship(xml: $0) : nil }

      self.fetchedProperties = try xml.children
         .compactMap { $0.element?.name == "fetchedProperty" ? try FetchedProperty(xml: $0) : nil }

      self.parentEntityName = xml.value(ofAttribute: "parentEntity")
      self.userInfo = try xml.userInfo()
   }
}
