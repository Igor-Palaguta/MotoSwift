import Foundation
import Stencil
import PathKit

public final class Renderer {
   private let template: Template
   private let fileName: String

   public init(templatePath: Path) throws {
      let templateString: String = try templatePath.read()
         .replacingOccurrences(of: "\n\n", with: "\n\u{000b}\n")
         .replacingOccurrences(of: "\n\n", with: "\n\u{000b}\n")

      self.template = Template(templateString: templateString)

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
      let renderedTemplate = try self.template.render(variables)

      return self.removeExtraLines(from: renderedTemplate)
   }

   // Workaround until Stencil fixes https://github.com/kylef/Stencil/issues/22
   private func removeExtraLines(from str: String) -> String {
      let extraLinesRE: NSRegularExpression = {
         do {
            return try NSRegularExpression(pattern: "\\n([ \\t]*\\n)+", options: [])
         } catch {
            fatalError("Regular Expression pattern error: \(error)")
         }
      }()
      let textRange = NSRange(location: 0, length: str.utf16.count)
      let compact = extraLinesRE.stringByReplacingMatches(in: str,
                                                          options: [],
                                                          range: textRange,
                                                          withTemplate: "\n")
      let unmarkedNewlines = compact
         .replacingOccurrences(of: "\n\u{000b}\n", with: "\n\n")
         .replacingOccurrences(of: "\n\u{000b}\n", with: "\n\n")
      return unmarkedNewlines
   }
}
