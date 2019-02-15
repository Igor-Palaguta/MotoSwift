import Foundation

public struct Entity {
   public let name: String
   public let className: String?
   public let attributes: [Attribute]
   public let relationships: [Relationship]
   public let fetchedProperties: [FetchedProperty]
   public let parentEntityName: String?
   public let userInfo: [String: String]
}
