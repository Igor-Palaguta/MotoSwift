import Foundation
import Stencil
import PathKit

public final class Renderer {
   private let template: Template
   private let namespace: Namespace
   private let fileName: String

   public init(templatePath: Path) throws {
      self.template = try MotoTemplate(path: templatePath)
      self.namespace = MotoNamespace()
      self.fileName = templatePath.lastComponent
   }

   public func render(entity: Entity, from model: Model) throws -> String {
      return try self.render(variables: try model.templateVariables(for: entity))
   }

   public func render(model: Model) throws -> String {
      return try self.render(variables: try model.templateVariables())
   }

   private func render(variables: [String: Any]) throws -> String {
      var variables = variables
      variables["file"] = self.fileName
      return try self.template.render(Context(dictionary: variables,
                                              namespace: self.namespace))
   }
}
