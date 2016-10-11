import Quick
import Nimble
/*import Stencil
import PathKit
@testable import MoGen

// Workaround until Stencil fixes https://github.com/kylef/Stencil/issues/22
class GenumTemplate: Template {
   public override init(templateString: String) {
      let templateStringWithMarkedNewlines = templateString
         .replacingOccurrences(of: "\n\n", with: "\n\u{000b}\n")
         .replacingOccurrences(of: "\n\n", with: "\n\u{000b}\n")
      super.init(templateString: templateStringWithMarkedNewlines)
   }

   public override func render(_ context: Context? = nil) throws -> String {
      return try removeExtraLines(super.render(context))
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
      let compact = extraLinesRE.stringByReplacingMatches(in: str,
                                                          options: [],
                                                          range: NSRange(location: 0, length: str.utf16.count),
                                                          withTemplate: "\n")
      let unmarkedNewlines = compact
         .replacingOccurrences(of: "\n\u{000b}\n", with: "\n\n")
         .replacingOccurrences(of: "\n\u{000b}\n", with: "\n\n")
      return unmarkedNewlines
   }
}

class CodeGeneratorSpec: QuickSpec {
   override func spec() {
      describe("CodeGenerator") {
         it("generateCode") {
            let modelPath = Bundle(for: type(of: self))
               .path(forResource: "TypesModel", ofType: "xcdatamodeld")!

            let model = try! ModelParser().parseModel(fromPath: modelPath)
            let machineTemplatePath = Bundle(for: type(of: self)).path(forResource: "machine", ofType: "stencil")!
            let machineTemplate = try! GenumTemplate(path: Path(machineTemplatePath))

            let humanTemplatePath = Bundle(for: type(of: self)).path(forResource: "human", ofType: "stencil")!
            let humanTemplate = try! GenumTemplate(path: Path(humanTemplatePath))

            for entity in model.entities {
               guard entity.className != nil else {
                  continue
               }
               let machine = try! machineTemplate.render(Context(dictionary: model.templateContext(for: entity)))
               print(machine)

               let human = try! humanTemplate.render(Context(dictionary: model.templateContext(for: entity)))
               print(human)
            }
         }
      }
   }
}*/
