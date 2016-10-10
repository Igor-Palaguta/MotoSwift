import Quick
import Nimble
import Stencil
import PathKit
@testable import MoGen

class CodeGeneratorSpec: QuickSpec {
   override func spec() {
      describe("CodeGenerator") {
         it("generateCode") {
            let modelPath = Bundle(for: type(of: self))
               .path(forResource: "TypesModel", ofType: "xcdatamodeld")!

            let model = try! ModelParser().parseModel(fromPath: modelPath)
            let machineTemplatePath = Bundle(for: type(of: self)).path(forResource: "machine", ofType: "stencil")!
            let machineTemplate = try! Template(path: Path(machineTemplatePath))

            let humanTemplatePath = Bundle(for: type(of: self)).path(forResource: "human", ofType: "stencil")!
            let humanTemplate = try! Template(path: Path(humanTemplatePath))

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
}
