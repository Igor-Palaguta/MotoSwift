import Foundation
import PathKit
import StencilSwiftKit

public final class Renderer {
   private let template: StencilSwiftTemplate
   private let commonVariables: [String: String]

   public init(templatePath: Path, customVariables: [String: String] = [:]) throws {
      self.template = StencilSwiftTemplate(templateString: try templatePath.read(),
                                           environment: stencilSwiftEnvironment())

      var allVariables = customVariables
      allVariables["file"] = templatePath.lastComponent

      self.commonVariables = allVariables
   }

   public func render(_ entity: Entity, from model: Model) throws -> String {
      return try render(try model.variables(for: entity))
   }

   public func render(_ model: Model) throws -> String {
      return try render(try model.variables())
   }

   private func render(_ variables: [String: Any]) throws -> String {
      let variables = variables.merging(commonVariables) { $1 }
      let renderedTemplate = try template.render(variables)
      return renderedTemplate
   }
}
