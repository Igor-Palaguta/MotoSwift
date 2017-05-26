import Foundation

extension Model {
   func variables(for entity: Entity) throws -> [String: Any] {
      return try entity.variables(for: .swift, self)
   }

   func variables() throws -> [String: Any] {
      let entitiesContexts = try self.entities.map {
         try $0.variables(for: .swift, self)
      }

      return ["entities": entitiesContexts]
   }
}

protocol Serializable {
   func variables(for language: Language, _ model: Model) throws -> [String: Any]
}

extension Entity: Serializable {
   fileprivate func ownVariables(for language: Language, _ model: Model) throws -> [String: Any] {
      var context: [String: Any] = self.userInfo
      context["name"] = self.name
      context["class"] = self.className
      return context
   }

   func variables(for language: Language, _ model: Model) throws -> [String: Any] {
      var context = try self.ownVariables(for: language, model)
      if let parentEntityName = self.parentEntityName,
         let parentEntity = model.index[parentEntityName] {
         context["parent"] = try parentEntity.variables(for: language, model)
      }
      context["attributes"] = try self.attributes.map {
         try $0.variables(for: language, model)
      }
      context["relationships"] = try self.relationships.map {
         try $0.variables(for: language, model)
      }
      context["fetchedProperties"] = try self.fetchedProperties.map {
         try $0.variables(for: language, model)
      }
      return context
   }
}

extension Attribute: Serializable {
   func variables(for language: Language, _ model: Model) throws -> [String: Any] {
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
   func variables(for language: Language, _ model: Model) throws -> [String: Any] {
      var context: [String: Any] = ["name": self.name,
                                    "entityName": self.entityName,
                                    "isOptional": self.isOptional,
                                    "toMany": self.toMany,
                                    "isOrdered": self.isOrdered]
      if let entity = model.index[self.entityName] {
         context["class"] = entity.className
         context["entity"] = try entity.ownVariables(for: language, model)
      }
      return context + self.userInfo
   }
}

extension FetchedProperty: Serializable {
   func variables(for language: Language, _ model: Model) throws -> [String: Any] {
      var context: [String: Any] = ["name": self.name,
                                    "entityName": self.entityName,
                                    "predicateString": self.predicateString]
      if let entity = model.index[self.entityName] {
         context["class"] = entity.className
         context["entity"] = try entity.ownVariables(for: language, model)
      }
      return context + self.userInfo
   }
}
