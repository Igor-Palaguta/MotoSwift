import Quick
import Nimble
@testable import MoGen

class CodeGeneratorSpec: QuickSpec {
   override func spec() {
      describe("CodeGenerator") {
         it("generateCode") {
            let modelPath = Bundle(for: type(of: self))
               .path(forResource: "TypesModel", ofType: "xcdatamodeld")!
            let model = try! ModelParser().parseModel(fromPath: modelPath)
            let machineTemplatePath = Bundle(for: type(of: self)).path(forResource: "machine", ofType: "stencil")!
            let humanTemplatePath = Bundle(for: type(of: self)).path(forResource: "human", ofType: "stencil")!
            let codeGenerator = try! CodeGenerator(language: .Swift, machineTemplatePath: machineTemplatePath, humanTemplatePath: humanTemplatePath)

            try! codeGenerator.generateCode(for: model) {
               entity, code in
               print(code.machine)
               print(code.human)
            }
         }
      }
   }
}
