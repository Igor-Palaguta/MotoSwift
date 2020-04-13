import Foundation
@testable import MotoSwiftFramework
import Nimble
import PathKit
import XCTest

final class ModelParserTests: XCTestCase {
    func testNonVersioned() throws {
        let modelPath = path(forResource: "TypesModel", ofType: "xcdatamodeld") + "TypesModel.xcdatamodel"
        try test(try ModelParser().parseModel(at: modelPath))
    }

    func testVersioned() throws {
        let modelPath = path(forResource: "TypesModel", ofType: "xcdatamodeld")
        try test(try ModelParser().parseModel(at: modelPath))
    }

    private func test(_ model: Model) throws {
        expect(model.entities.count) == 4
        let allTypesEntity = model.entityByName["AllTypes"]!
        expect(allTypesEntity.name) == "AllTypes"
        expect(allTypesEntity.className) == "AllTypesClass"

        let relationships = Relationship(name: "properties", entityName: "Property", isOptional: true, toMany: true, isOrdered: false, userInfo: [:])

        expect(allTypesEntity.relationships).to(contain(relationships))

        let nonNumericTypesMapping: [AttributeType: String] = [
            .binary: "data",
            .date: "date",
            .string: "string",
            .transformable: "transformable"
        ]

        let nonNumericAttributes: [Attribute] = nonNumericTypesMapping.map {
            Attribute(name: $1,
                      type: $0,
                      isOptional: true,
                      isScalar: false,
                      userInfo: [:])
        }

        expect(allTypesEntity.attributes).to(contain(nonNumericAttributes))
        expect(allTypesEntity.parentEntityName) == "NumericTypes"
        expect(allTypesEntity.userInfo) == ["description": "all types"]

        let numericTypesEntity = model.entityByName["NumericTypes"]!
        let numericTypesMapping: [AttributeType: String] = [
            .boolean: "boolean",
            .decimal: "decimal",
            .double: "double",
            .float: "float",
            .integer16: "int16",
            .integer32: "int32",
            .integer64: "int64"
        ]

        let numericAttributes: [Attribute] = numericTypesMapping.map {
            Attribute(name: $1,
                      type: $0,
                      isOptional: true,
                      isScalar: false,
                      userInfo: [:])
        }

        expect(numericTypesEntity.attributes).to(contain(numericAttributes))

        let scalarTypesEntity = model.entityByName["ScalarTypes"]!

        let scalarAttributes: [Attribute] = numericTypesMapping
            .filter { $0.key != .decimal }
            .map { Attribute(name: $1, type: $0, isOptional: false, isScalar: true, userInfo: [:]) }

        expect(scalarTypesEntity.attributes).to(contain(scalarAttributes))

        let expectedRelationship = Relationship(name: "numerics", entityName: "NumericTypes", isOptional: false, toMany: false, isOrdered: false, userInfo: [:])

        expect(scalarTypesEntity.relationships).to(contain(expectedRelationship))

        let expectedFetchedProperties: [FetchedProperty] =
            [FetchedProperty(name: "gt100", entityName: "ScalarTypes", predicateString: "int16 > 100", userInfo: [:]),
             FetchedProperty(name: "eqTrue", entityName: "ScalarTypes", predicateString: "boolean == YES", userInfo: [:])]

        expect(scalarTypesEntity.fetchedProperties).to(contain(expectedFetchedProperties))
    }

}
