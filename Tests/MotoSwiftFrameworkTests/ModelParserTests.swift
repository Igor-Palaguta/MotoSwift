import XCTest
import Foundation
@testable import MotoSwiftFramework

private func path(forResource resource: String, ofType type: String) -> String {
   #if SWIFT_PACKAGE
      let relativePath = "Tests/MotoSwiftFrameworkTests/Resources/\(resource).\(type)"
      return URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
         .appendingPathComponent(relativePath)
         .path
   #else
      return Bundle(for: type(of: ModelParserTests.self)).path(forResource: resource, ofType: type)
   #endif
}

extension Collection where Iterator.Element: Equatable {
   func hasSameElements(with other: Self) -> Bool {
      guard self.count == other.count else {
         return false
      }

      return !self.contains { !other.contains($0) }
   }
}

class ModelParserTests: XCTestCase {

   func testNonVersionedModel() {
      let modelPath = URL(fileURLWithPath: path(forResource: "TypesModel", ofType: "xcdatamodeld"))
         .appendingPathComponent("TypesModel.xcdatamodel")
         .path
      let model = try! ModelParser().parseModel(fromPath: modelPath)
      XCTAssert(model.entities.count == 3, "Entities parsed")
   }

   func testVersionedModel() {
      let modelPath = path(forResource: "TypesModel", ofType: "xcdatamodeld")
      let model = try! ModelParser().parseModel(fromPath: modelPath)
      let allTypesEntity = model.index["AllTypes"]!
      XCTAssert(allTypesEntity.name == "AllTypes", "name")
      XCTAssert(allTypesEntity.className == "AllTypesClass", "className")
      XCTAssert(allTypesEntity.relationships.isEmpty, "relationships.isEmpty")

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

      XCTAssert(allTypesEntity.attributes.hasSameElements(with: nonNumericAttributes), "allTypesEntity.attributes")
      XCTAssert(allTypesEntity.parentEntityName == "NumericTypes", "parentEntityName")
      XCTAssert(allTypesEntity.userInfo == ["description": "all types"], "userInfo")

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


      XCTAssert(numericTypesEntity.attributes.hasSameElements(with: numericAttributes), "numericTypesEntity.attributes")

      let scalarTypesEntity = model.index["ScalarTypes"]!

      let scalarAttributes: [Attribute] = numericTypesMapping
         .filter { $0.key != .Decimal }
         .map { Attribute(name: $1, type: $0, isOptional: false, isScalar: true, userInfo: [:]) }


      XCTAssert(scalarTypesEntity.attributes.hasSameElements(with: scalarAttributes), "scalarTypesEntity.attributes")

      let expectedRelationship = Relationship(name: "numerics", entityName: "NumericTypes", isOptional: false, toMany: false, isOrdered: false, userInfo: [:])

      XCTAssert(scalarTypesEntity.relationships.hasSameElements(with: [expectedRelationship]), "scalarTypesEntity.relationships")

      let expectedFetchedProperties: [FetchedProperty] =
         [FetchedProperty(name: "gt_100", entityName: "ScalarTypes", predicateString: "int16 > 100", userInfo: [:]),
          FetchedProperty(name: "eq_true", entityName: "ScalarTypes", predicateString: "boolean == YES", userInfo: [:])
      ]

      XCTAssert(scalarTypesEntity.fetchedProperties.hasSameElements(with: expectedFetchedProperties), "scalarTypesEntity.fetchedProperties")
   }
}
