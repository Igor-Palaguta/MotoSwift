import Foundation
import SWXMLHash

extension Attribute {
   init(xml: XMLIndexer) throws {
      self.name = try xml.value(ofAttribute: "name")
      self.type = try AttributeType(stringValue: try xml.value(ofAttribute: "attributeType"))
      self.isScalar = xml.value(ofAttribute: "usesScalarValueType") ?? false
      self.isOptional = xml.value(ofAttribute: "optional") ?? false
      self.userInfo = try xml.userInfo()
   }
}

private let typesMapping: [String: AttributeType] = ["Boolean": .Boolean,
                                                     "Binary": .Binary,
                                                     "Date": .Date,
                                                     "Decimal": .Decimal,
                                                     "Double": .Double,
                                                     "Float": .Float,
                                                     "Integer 16": .Integer16,
                                                     "Integer 32": .Integer32,
                                                     "Integer 64": .Integer64,
                                                     "String": .String,
                                                     "Transformable": .Transformable]

extension AttributeType {
   fileprivate init(stringValue: String) throws {
      guard let type = typesMapping[stringValue] else {
         throw MotoSwiftError("Unexpected attribute type: '\(stringValue)'")
      }
      self = type
   }
}
