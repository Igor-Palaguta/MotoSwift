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

private let typesMapping: [String: AttributeType] = ["Boolean": .boolean,
                                                     "Binary": .binary,
                                                     "Date": .date,
                                                     "Decimal": .decimal,
                                                     "Double": .double,
                                                     "Float": .float,
                                                     "Integer 16": .integer16,
                                                     "Integer 32": .integer32,
                                                     "Integer 64": .integer64,
                                                     "String": .string,
                                                     "Transformable": .transformable]

extension AttributeType {
   fileprivate init(stringValue: String) throws {
      guard let type = typesMapping[stringValue] else {
         throw UnknownAttributeType(type: stringValue)
      }
      self = type
   }
}

private struct UnknownAttributeType: Error, CustomStringConvertible {
   let type: String
   public var description: String {
      return "Unexpected attribute type: '\(type)'"
   }
}
