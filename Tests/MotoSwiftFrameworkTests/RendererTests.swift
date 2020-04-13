import Foundation
@testable import MotoSwiftFramework
import Nimble
import XCTest

final class RendererTests: XCTestCase {
    private var model: Model!

    override func setUpWithError() throws {
        let modelPath = path(forResource: "TypesModel", ofType: "xcdatamodeld")
        model = try ModelParser().parseModel(at: modelPath)
    }

    func testEntities() throws {
        let templatePath = path(forResource: "machine", ofType: "stencil")
        let renderer = try Renderer(templatePath: templatePath)

        for entityName in ["AllTypes", "NumericTypes", "Property", "ScalarTypes"] {
            let entity = model.entityByName[entityName]!
            let className = entity.className!
            let code = try renderer.render(entity, from: model)
            let expectedEntityPath = path(forResource: "_\(className)", ofType: "swift.out")
            let expectedCode: String = try expectedEntityPath.read()
            expect(code) == expectedCode
        }
    }

    func testModel() throws {
        let templatePath = path(forResource: "model", ofType: "stencil")
        let renderer = try Renderer(templatePath: templatePath)

        let code = try renderer.render(model)
        let expectedEntityPath = path(forResource: "Model", ofType: "swift.out")
        let expectedCode: String = try expectedEntityPath.read()
        expect(code) == expectedCode
    }
}
