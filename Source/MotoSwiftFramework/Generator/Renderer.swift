import Foundation
import Stencil
import PathKit

public final class Renderer {
   private let template: Template
   private let namespace: Namespace

   public init(templatePath: String) throws {
      self.template = try MotoTemplate(path: Path(templatePath))
      self.namespace = MotoNamespace()
   }

   public func render(entity: Entity, from model: Model) throws -> String {
      return try self.template.render(Context(dictionary: try model.templateContext(for: entity),
                                         namespace: self.namespace))
   }

   public func render(model: Model) throws -> String {
      return try self.template.render(Context(dictionary: try model.templateContext(),
                                              namespace: self.namespace))
   }
}
