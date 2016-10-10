import Foundation

public struct Model {
   public let entities: [Entity]
   public let index: [String: Entity]

   init(_ entities: [Entity]) {
      self.entities = entities
      self.index = entities.reduce([:]) { $0 + [$1.name: $1] }
   }
}
