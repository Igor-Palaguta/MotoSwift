import Quick
import Nimble
@testable import MotoSwiftFramework

class ModelParserSpec: QuickSpec {
   override func spec() {
      describe("ModelParser") {
         it("parses xcdatamodeld") {
            let modelPath = Bundle(for: type(of: self))
               .path(forResource: "TypesModel", ofType: "xcdatamodeld")!
            let model = try! ModelParser().parseModel(fromPath: modelPath)
            expect(model.entities.count) == 3
         }
         it("parses xcdatamodel") {
            let modelPath = URL(fileURLWithPath: Bundle(for: type(of: self)).path(forResource: "TypesModel", ofType: "xcdatamodeld")!)
               .appendingPathComponent("TypesModel.xcdatamodel")
               .path
            let model = try! ModelParser().parseModel(fromPath: modelPath)
            expect(model.entities.count) == 3
         }

         it("parses entities") {
            let modelPath = Bundle(for: type(of: self))
               .path(forResource: "TypesModel", ofType: "xcdatamodeld")!
            let model = try! ModelParser().parseModel(fromPath: modelPath)
            let allTypesEntity = model.index["AllTypes"]!
            expect(allTypesEntity.name) == "AllTypes"
            expect(allTypesEntity.className) == "AllTypesClass"
            expect(allTypesEntity.relationships.isEmpty).to(beTrue())

            let nonNumericTypesMapping: [AttributeType: String] = [.Binary: "data",
                                                                   .Date: "date",
                                                                   .String: "string",
                                                                   .Transformable: "transformable"]

            let nonNumericAttributes: [Attribute] = nonNumericTypesMapping.map {
               Attribute(name: $1,
                         type: $0,
                         isOptional: true,
                         isScalar: false,
                         userInfo: [:])
            }

            expect(allTypesEntity.attributes.count) == nonNumericAttributes.count
            expect(allTypesEntity.attributes).to(contain(nonNumericAttributes))
            expect(allTypesEntity.parentEntityName) == "NumericTypes"
            expect(allTypesEntity.userInfo) == ["description": "all types"]

            let numericTypesEntity = model.index["NumericTypes"]!
            let numericTypesMapping: [AttributeType: String] = [.Boolean: "boolean",
                                                                .Decimal: "decimal",
                                                                .Double: "double",
                                                                .Float: "float",
                                                                .Integer16: "int16",
                                                                .Integer32: "int32",
                                                                .Integer64: "int64"]

            let numericAttributes: [Attribute] = numericTypesMapping.map {
               Attribute(name: $1,
                         type: $0,
                         isOptional: true,
                         isScalar: false,
                         userInfo: [:])
            }

            expect(numericTypesEntity.attributes.count) == numericAttributes.count
            expect(numericTypesEntity.attributes).to(contain(numericAttributes))

            let scalarTypesEntity = model.index["ScalarTypes"]!

            let scalarAttributes: [Attribute] = numericTypesMapping
               .filter { $0.key != .Decimal }
               .map { Attribute(name: $1, type: $0, isOptional: false, isScalar: true, userInfo: [:]) }

            expect(scalarTypesEntity.attributes.count) == scalarAttributes.count
            expect(scalarTypesEntity.attributes).to(contain(scalarAttributes))

            let expectedRelationship = Relationship(name: "numerics", entityName: "NumericTypes", isOptional: false, toMany: false, isOrdered: false, userInfo: [:])
            expect(scalarTypesEntity.relationships.count) == 1
            expect(scalarTypesEntity.relationships).to(contain(expectedRelationship))

            let expectedFetchedProperties: [FetchedProperty] =
               [FetchedProperty(name: "gt_100", entityName: "ScalarTypes", predicateString: "int16 > 100", userInfo: [:]),
                FetchedProperty(name: "eq_true", entityName: "ScalarTypes", predicateString: "boolean == YES", userInfo: [:])
                ]
            expect(scalarTypesEntity.fetchedProperties.count) == 2
            expect(scalarTypesEntity.fetchedProperties).to(contain(expectedFetchedProperties))
         }
      }
   }
}
