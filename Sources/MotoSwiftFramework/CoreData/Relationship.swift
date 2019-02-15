import Foundation

public struct Relationship: Equatable {
   public let name: String
   public let entityName: String
   public let isOptional: Bool
   public let toMany: Bool
   public let isOrdered: Bool
   public let userInfo: [String: String]
}
