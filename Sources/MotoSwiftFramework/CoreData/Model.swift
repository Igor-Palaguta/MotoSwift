import Foundation

public struct Model {
   public let entities: [Entity]
   public let index: [String: Entity]

   init(_ entities: [Entity]) {
      self.entities = entities
      self.index = Dictionary(uniqueKeysWithValues: entities.map { ($0.name, $0) })
   }
}
