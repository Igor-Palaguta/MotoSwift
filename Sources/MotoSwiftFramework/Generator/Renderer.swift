import Foundation
import PathKit
import StencilSwiftKit

public final class Renderer {
   private let template: StencilSwiftTemplate
   private let commonVariables: [String: String]

   public init(templatePath: Path) throws {
      self.template = StencilSwiftTemplate(templateString: try templatePath.read(),
                                           environment: stencilSwiftEnvironment())

      self.commonVariables = ["file": templatePath.lastComponent]
   }

   public func render(_ entity: Entity, from model: Model) throws -> String {
      return try render(variables: try model.variables(for: entity))
   }

   public func render(_ model: Model) throws -> String {
      return try render(variables: try model.variables())
   }

   private func render(variables: [String: Any]) throws -> String {
      let variables = variables.merging(commonVariables) { $1 }
      let renderedTemplate = try template.render(variables)
      return renderedTemplate
   }
}
