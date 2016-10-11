import Foundation

extension Model {
   public func templateContext(for entity: Entity) throws -> [String: Any] {
      return try entity.templateContext(language: .Swift, model: self)
   }

   public func templateContext() throws -> [String: Any] {
      let entitiesContexts = try self.entities.map { try $0.templateContext(language: .Swift, model: self) }

      return ["entities": entitiesContexts]
   }
}

protocol TemplateContext {
   func templateContext(language: Language, model: Model) throws -> [String: Any]
}

extension Entity: TemplateContext {
   func templateContext(language: Language, model: Model) throws -> [String: Any] {
      var context: [String: Any] = ["name": self.name]
      context["class"] = self.className
      if let parentEntityName = self.parentEntityName,
         let parentClassName = model.index[parentEntityName]?.className {
         context["parentClass"] = parentClassName
      }
      context["attributes"] = try self.attributes.map {
         try $0.templateContext(language: language, model: model)
      }
      context["relationships"] = try self.relationships.map {
         try $0.templateContext(language: language, model: model)
      }
      context["fetchedProperties"] = try self.fetchedProperties.map {
         try $0.templateContext(language: language, model: model)
      }
      return context + self.userInfo
   }
}

extension Attribute: TemplateContext {
   func templateContext(language: Language, model: Model) throws -> [String: Any] {
      let context: [String: Any] = ["name": self.name,
                                    "type": try language.type(for: self.type, scalar: self.isScalar),
                                    "isOptional": self.isOptional,
                                    "isScalar": self.isScalar]
      return context + self.userInfo
   }
}

extension Relationship: TemplateContext {
   func templateContext(language: Language, model: Model) throws -> [String: Any] {
      var context: [String: Any] = ["name": name,
                                    "entityName": self.entityName,
                                    "isOptional": self.isOptional,
                                    "toMany": self.toMany,
                                    "isOrdered": self.isOrdered]

      if let className = model.index[self.entityName]?.className {
         context["class"] = className
      }
      return context + self.userInfo
   }
}

extension FetchedProperty: TemplateContext {
   func templateContext(language: Language, model: Model) throws -> [String: Any] {
      var context: [String: Any] = ["name": self.name,
                                    "entityName": self.entityName,
                                    "predicateString": self.predicateString]

      if let className = model.index[self.entityName]?.className {
         context["class"] = className
      }
      return context + self.userInfo
   }
}
