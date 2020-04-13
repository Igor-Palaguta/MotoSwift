import Foundation
@testable import MotoSwiftFramework
import Spectre

func testRenderer() {
    describe("Renderer") {
        let modelPath = path(forResource: "TypesModel", ofType: "xcdatamodeld")
        let model = try! ModelParser().parseModel(at: modelPath)

        $0.it("renders entity") {
            let templatePath = path(forResource: "machine", ofType: "stencil")
            let renderer = try Renderer(templatePath: templatePath)

            for entity in model.entities {
                guard let className = entity.className else {
                    return
                }
                let code = try renderer.render(entity, from: model)
                let expectedEntityPath = path(forResource: "_\(className)", ofType: "swift.out")
                let expectedCode: String = try expectedEntityPath.read()
                try expect(code) == expectedCode
            }
        }
        $0.it("renders model") {
            let templatePath = path(forResource: "model", ofType: "stencil")
            let renderer = try Renderer(templatePath: templatePath)

            let code = try renderer.render(model)
            let expectedEntityPath = path(forResource: "Model", ofType: "swift.out")
            let expectedCode: String = try expectedEntityPath.read()
            try expect(code) == expectedCode
        }
    }
}
