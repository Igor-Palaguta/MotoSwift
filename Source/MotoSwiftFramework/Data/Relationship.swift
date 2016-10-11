import Foundation

public struct Relationship: Equatable {
   public let name: String
   public let entityName: String
   public let isOptional: Bool
   public let toMany: Bool
   public let isOrdered: Bool
   public let userInfo: [String: String]

   public static func == (lhs: Relationship, rhs: Relationship) -> Bool {
      return lhs.name == rhs.name &&
         lhs.entityName == rhs.entityName &&
         lhs.isOptional == rhs.isOptional &&
         lhs.toMany == rhs.toMany &&
         lhs.isOrdered == rhs.isOrdered &&
         lhs.userInfo == rhs.userInfo
   }
}
