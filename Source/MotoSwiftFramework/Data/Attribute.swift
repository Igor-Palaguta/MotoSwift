import Foundation

public enum AttributeType {
   case binary
   case boolean
   case date
   case decimal
   case double
   case float
   case integer16
   case integer32
   case integer64
   case string
   case transformable
}

public struct Attribute: Equatable {
   public let name: String
   public let type: AttributeType
   public let isOptional: Bool
   public let isScalar: Bool
   public let userInfo: [String: String]

   public static func == (lhs: Attribute, rhs: Attribute) -> Bool {
      return lhs.name == rhs.name &&
         lhs.type == rhs.type &&
         lhs.isOptional == rhs.isOptional &&
         lhs.isScalar == rhs.isScalar &&
         lhs.userInfo == rhs.userInfo
   }
}
