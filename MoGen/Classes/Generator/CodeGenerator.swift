import Foundation
import Stencil
import PathKit

public struct EntityCode {
   public let machine: String
   public let human: String
}

public final class CodeGenerator {

   private let language: Language
   private let machineTemplate: Template
   private let humanTemplate: Template

   public init(language: Language,
               machineTemplate: Template,
               humanTemplate: Template) {
      self.language = language
      self.machineTemplate = machineTemplate
      self.humanTemplate = humanTemplate
   }

   public convenience init(language: Language,
                    machineTemplatePath: String,
                    humanTemplatePath: String) throws {
      self.init(language: language,
                machineTemplate: try Template(path: Path(machineTemplatePath)),
                humanTemplate: try Template(path: Path(humanTemplatePath)))
   }

   public func generateCode(for model: Model,
                            enumerator: (Entity, EntityCode) throws -> Void) throws {
      for entity in model.entities {
         if entity.className == nil {
            continue
         }
         let namespace = Namespace()
         let context = Context(dictionary: try entity.templateContext(language: self.language,
                                                                      model: model),
                               namespace: namespace)
         try enumerator(entity, EntityCode(machine: try self.machineTemplate.render(context),
                                           human: try self.humanTemplate.render(context)))
      }
   }
}

protocol TemplateContext {
   func templateContext(language: Language, model: Model) throws -> [String: Any]
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

extension Entity: TemplateContext {
   func templateContext(language: Language, model: Model) throws -> [String: Any] {
      var context: [String: Any] = ["class": self.className!, "name": self.name]
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
