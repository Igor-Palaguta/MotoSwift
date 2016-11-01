import Foundation

extension Model {
   func templateVariables(for entity: Entity) throws -> [String: Any] {
      return try entity.templateVariables(language: .Swift, model: self)
   }

   func templateVariables() throws -> [String: Any] {
      let entitiesContexts = try self.entities.map {
         try $0.templateVariables(language: .Swift, model: self)
      }

      return ["entities": entitiesContexts]
   }
}

protocol TemplateContext {
   func templateVariables(language: Language, model: Model) throws -> [String: Any]
}

extension Entity: TemplateContext {
   func templateVariables(language: Language, model: Model) throws -> [String: Any] {
      var context: [String: Any] = ["name": self.name]
      context["class"] = self.className
      if let parentEntityName = self.parentEntityName,
         let parentClassName = model.index[parentEntityName]?.className {
         context["parentClass"] = parentClassName
      }
      context["attributes"] = try self.attributes.map {
         try $0.templateVariables(language: language, model: model)
      }
      context["relationships"] = try self.relationships.map {
         try $0.templateVariables(language: language, model: model)
      }
      context["fetchedProperties"] = try self.fetchedProperties.map {
         try $0.templateVariables(language: language, model: model)
      }
      return context + self.userInfo
   }
}

extension Attribute: TemplateContext {
   func templateVariables(language: Language, model: Model) throws -> [String: Any] {
      var context: [String: Any] = ["name": self.name,
                                    "type": language.type(for: self.type),
                                    "isOptional": self.isOptional,
                                    "isScalar": self.isScalar]
      context["scalarType"] = language.scalarType(for: self.type)
      return context + self.userInfo
   }
}

extension Relationship: TemplateContext {
   func templateVariables(language: Language, model: Model) throws -> [String: Any] {
      var context: [String: Any] = ["name": self.name,
                                    "entityName": self.entityName,
                                    "isOptional": self.isOptional,
                                    "toMany": self.toMany,
                                    "isOrdered": self.isOrdered]
      context["class"] = model.index[self.entityName]?.className
      return context + self.userInfo
   }
}

extension FetchedProperty: TemplateContext {
   func templateVariables(language: Language, model: Model) throws -> [String: Any] {
      var context: [String: Any] = ["name": self.name,
                                    "entityName": self.entityName,
                                    "predicateString": self.predicateString]
      context["class"] = model.index[self.entityName]?.className
      return context + self.userInfo
   }
}
