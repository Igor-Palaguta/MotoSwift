import Foundation

public struct Model {
    public let name: String
    public let entities: [Entity]
    public let index: [String: Entity]

    init(name: String, entities: [Entity]) {
        self.name = name
        self.entities = entities
        self.index = Dictionary(entities.map { ($0.name, $0) }) { $1 }
    }
}
