import Foundation

public struct FetchedProperty: Equatable {
   public let name: String
   public let entityName: String
   public let predicateString: String
   public let userInfo: [String: String]

   public static func == (lhs: FetchedProperty, rhs: FetchedProperty) -> Bool {
      return lhs.name == rhs.name &&
         lhs.entityName == rhs.entityName &&
         lhs.predicateString == rhs.predicateString &&
         lhs.userInfo == rhs.userInfo
   }
}
