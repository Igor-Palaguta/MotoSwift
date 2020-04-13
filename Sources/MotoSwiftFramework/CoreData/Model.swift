import Foundation

public struct Model {
    public let name: String
    public let entities: [Entity]
    public let entityByName: [String: Entity]

    init(name: String, entities: [Entity]) {
        self.name = name
        self.entities = entities
        self.entityByName = Dictionary(entities.map { ($0.name, $0) }) { $1 }
    }
}
