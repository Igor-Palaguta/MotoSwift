import Foundation

public enum AttributeType {
   case Binary
   case Boolean
   case Date
   case Decimal
   case Double
   case Float
   case Integer16
   case Integer32
   case Integer64
   case String
   case Transformable
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
