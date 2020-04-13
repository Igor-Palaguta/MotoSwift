import Foundation
@testable import MotoSwiftFramework
import PathKit
import Spectre

func testModelParser() {
    describe("ModelParser") {
        $0.it("parses non versioned model") {
            let modelPath = path(forResource: "TypesModel", ofType: "xcdatamodeld") + "TypesModel.xcdatamodel"
            try test(typeModel: try ModelParser().parseModel(at: modelPath))
        }

        $0.it("parses versioned model") {
            let modelPath = path(forResource: "TypesModel", ofType: "xcdatamodeld")
            try test(typeModel: try ModelParser().parseModel(at: modelPath))
        }
    }
}

private func test(typeModel model: Model) throws {
    try expect(model.entities.count) == 4
    let allTypesEntity = model.index["AllTypes"]!
    try expect(allTypesEntity.name) == "AllTypes"
    try expect(allTypesEntity.className) == "AllTypesClass"

    let properties = Relationship(name: "properties", entityName: "Property", isOptional: true, toMany: true, isOrdered: false, userInfo: [:])

    try expect(allTypesEntity.relationships).to.containsSameElements(with: [properties])

    let nonNumericTypesMapping: [AttributeType: String] = [.binary: "data",
                                                           .date: "date",
                                                           .string: "string",
                                                           .transformable: "transformable"]

    let nonNumericAttributes: [Attribute] = nonNumericTypesMapping.map {
        Attribute(name: $1,
                  type: $0,
                  isOptional: true,
                  isScalar: false,
                  userInfo: [:])
    }

    try expect(allTypesEntity.attributes).to.containsSameElements(with: nonNumericAttributes)
    try expect(allTypesEntity.parentEntityName) == "NumericTypes"
    try expect(allTypesEntity.userInfo) == ["description": "all types"]

    let numericTypesEntity = model.index["NumericTypes"]!
    let numericTypesMapping: [AttributeType: String] = [.boolean: "boolean",
                                                        .decimal: "decimal",
                                                        .double: "double",
                                                        .float: "float",
                                                        .integer16: "int16",
                                                        .integer32: "int32",
                                                        .integer64: "int64"]

    let numericAttributes: [Attribute] = numericTypesMapping.map {
        Attribute(name: $1,
                  type: $0,
                  isOptional: true,
                  isScalar: false,
                  userInfo: [:])
    }

    try expect(numericTypesEntity.attributes).to.containsSameElements(with: numericAttributes)

    let scalarTypesEntity = model.index["ScalarTypes"]!

    let scalarAttributes: [Attribute] = numericTypesMapping
        .filter { $0.key != .decimal }
        .map { Attribute(name: $1, type: $0, isOptional: false, isScalar: true, userInfo: [:]) }

    try expect(scalarTypesEntity.attributes).to.containsSameElements(with: scalarAttributes)

    let expectedRelationship = Relationship(name: "numerics", entityName: "NumericTypes", isOptional: false, toMany: false, isOrdered: false, userInfo: [:])

    try expect(scalarTypesEntity.relationships).to.containsSameElements(with: [expectedRelationship])

    let expectedFetchedProperties: [FetchedProperty] =
        [FetchedProperty(name: "gt100", entityName: "ScalarTypes", predicateString: "int16 > 100", userInfo: [:]),
         FetchedProperty(name: "eqTrue", entityName: "ScalarTypes", predicateString: "boolean == YES", userInfo: [:])]

    try expect(scalarTypesEntity.fetchedProperties).to.containsSameElements(with: expectedFetchedProperties)
}
