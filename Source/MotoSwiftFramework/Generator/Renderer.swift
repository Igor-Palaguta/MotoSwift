import Foundation
import Stencil
import PathKit

public final class Renderer {
   private let template: Template
   private let namespace: Namespace
   private let fileName: String

   public init(templatePath: Path) throws {
      let templateString: String = try templatePath.read()
         .replacingOccurrences(of: "\n\n", with: "\n\u{000b}\n")
         .replacingOccurrences(of: "\n\n", with: "\n\u{000b}\n")
      self.template = Template(templateString: templateString)

      self.namespace = Namespace()
      self.namespace.registerFilter("titlecase", filter: StringFilters.titlecase)

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
      let renderedTemplate = try self.template.render(Context(dictionary: variables,
                                                              namespace: self.namespace))

      return self.removeExtraLines(renderedTemplate)
   }

   // Workaround until Stencil fixes https://github.com/kylef/Stencil/issues/22
   private func removeExtraLines(_ str: String) -> String {
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

enum FilterError: Error {
   case invalidInputType
}

private struct StringFilters {

   static func titlecase(value: Any?) throws -> Any? {
      guard let string = value as? String else { throw FilterError.invalidInputType }
      return titlecase(string: string)
   }

   static func titlecase(string: String) -> String {
      guard let first = string.unicodeScalars.first else { return string }
      return String(first).uppercased() + String(string.unicodeScalars.dropFirst())
   }
}
