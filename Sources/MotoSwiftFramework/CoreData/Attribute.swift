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

   var isInteger: Bool {
      switch self {
      case .integer16, .integer32, .integer64:
         return true
      default:
         return false
      }
   }

   var isFloat: Bool {
      switch self {
      case .float, .double:
         return true
      default:
         return false
      }
   }
}

public struct Attribute: Equatable {
   public let name: String
   public let type: AttributeType
   public let isOptional: Bool
   public let isScalar: Bool
   public let userInfo: [String: String]
}
