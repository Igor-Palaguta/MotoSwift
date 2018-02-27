import Foundation
import Stencil
import PathKit
import StencilSwiftKit

public final class Renderer {
   private let template: StencilSwiftKit.StencilSwiftTemplate
   private let commonVariables: [String: String]

    public init(templatePath: Path, modelPath: Path) throws {
      let templateString: String = try templatePath.read()
         .replacingOccurrences(of: "\n\n", with: "\n\u{000b}\n")
         .replacingOccurrences(of: "\n\n", with: "\n\u{000b}\n")
    let env = stencilSwiftEnvironment()
    self.template = StencilSwiftKit.StencilSwiftTemplate(templateString: templateString, environment: env)

      self.commonVariables = ["file": templatePath.lastComponent,
                              "modelName": modelPath.lastComponentWithoutExtension]
   }

   public func render(_ entity: Entity, from model: Model) throws -> String {
      return try self.render(try model.variables(for: entity))
   }

   public func render(_ model: Model) throws -> String {
      return try self.render(try model.variables())
   }

//    private static func motoSwiftEnvironment(templatePath: Path? = nil) -> Stencil.Environment {
//        let ext = Stencil.Extension()
//
//        var extensions = stencilSwiftEnvironment().extensions
//        extensions.append(ext)
//        let loader = templatePath.map({ FileSystemLoader(paths: [$0.parent()]) })
//        return Environment(loader: loader, extensions: extensions, templateClass: StencilSwiftKit.StencilSwiftTemplate.self)
//    }
    
   private func render(_ variables: [String: Any]) throws -> String {
      let variables = variables + self.commonVariables
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
