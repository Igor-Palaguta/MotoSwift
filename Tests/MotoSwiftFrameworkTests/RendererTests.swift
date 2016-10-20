import Foundation
import Spectre
@testable import MotoSwiftFramework

func testRenderer() {
   describe("Renderer") {
      let modelPath = url(forResource: "TypesModel", ofType: "xcdatamodeld").path
      let model = try! ModelParser().parseModel(fromPath: modelPath)

      $0.it("renders entity") {
         let templatePath = url(forResource: "machine", ofType: "stencil").path
         let renderer = try Renderer(templatePath: templatePath)

         for entity in model.entities {
            guard let className = entity.className else {
               return
            }
            let code = try renderer.render(entity: entity, from: model)
            let expectedEntityUrl = url(forResource: "_\(className)", ofType: "swift")
            let expectedCode = try String(contentsOf: expectedEntityUrl, encoding: .utf8)
            try expect(code) == expectedCode
         }
      }
      $0.it("renders model") {
         let templatePath = url(forResource: "model", ofType: "stencil").path
         let renderer = try Renderer(templatePath: templatePath)

         let code = try renderer.render(model: model)
         let expectedEntityUrl = url(forResource: "Model", ofType: "swift")
         let expectedCode = try String(contentsOf: expectedEntityUrl, encoding: .utf8)
         try expect(code) == expectedCode
      }
   }
}
