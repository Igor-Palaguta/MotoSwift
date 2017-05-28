import Foundation

extension Model {
   func variables(for entity: Entity) throws -> [String: Any] {
      return try entity.variables(with: .swift, index: self.index)
   }

   func variables() throws -> [String: Any] {
      let entitiesContexts = try self.entities.map {
         try $0.variables(with: .swift, index: self.index)
      }

      return ["entities": entitiesContexts]
   }
}

protocol Serializable {
   func variables(with language: Language, index: [String: Entity]) throws -> [String: Any]
}

extension Entity: Serializable {
   fileprivate func variables(with language: Language) throws -> [String: Any] {
      var context: [String: Any] = self.userInfo
      context["name"] = self.name
      context["class"] = self.className
      return context
   }

   func variables(with language: Language, index: [String: Entity]) throws -> [String: Any] {
      var context = try self.variables(with: language)
      if let parentEntityName = self.parentEntityName,
         let parent = index[parentEntityName] {
         context["parent"] = try parent.variables(with: language, index: index)
      }
      context["attributes"] = try self.attributes.map {
         try $0.variables(with: language, index: index)
      }
      context["relationships"] = try self.relationships.map {
         try $0.variables(with: language, index: index)
      }
      context["fetchedProperties"] = try self.fetchedProperties.map {
         try $0.variables(with: language, index: index)
      }
      return context
   }
}

extension Attribute: Serializable {
   func variables(with language: Language, index: [String: Entity]) throws -> [String: Any] {
      var context: [String: Any] = ["name": self.name,
                                    "type": language.scalarType(for: self.type) ?? language.objectType(for: self.type),
                                    "objectType": language.objectType(for: self.type),
                                    "isOptional": self.isOptional,
                                    "isScalar": self.isScalar,
                                    "isInteger": self.type.isInteger,
                                    "isFloat": self.type.isFloat]
      context["scalarType"] = language.scalarType(for: self.type)
      return context + self.userInfo
   }
}

extension Relationship: Serializable {
   func variables(with language: Language, index: [String: Entity]) throws -> [String: Any] {
      var context: [String: Any] = ["name": self.name,
                                    "entityName": self.entityName,
                                    "isOptional": self.isOptional,
                                    "toMany": self.toMany,
                                    "isOrdered": self.isOrdered]
      if let entity = index[self.entityName] {
         context["class"] = entity.className
         context["entity"] = try entity.variables(with: language)
      }
      return context + self.userInfo
   }
}

extension FetchedProperty: Serializable {
   func variables(with language: Language, index: [String: Entity]) throws -> [String: Any] {
      var context: [String: Any] = ["name": self.name,
                                    "entityName": self.entityName,
                                    "predicateString": self.predicateString]
      if let entity = index[self.entityName] {
         context["class"] = entity.className
         context["entity"] = try entity.variables(with: language)
      }
      return context + self.userInfo
   }
}
