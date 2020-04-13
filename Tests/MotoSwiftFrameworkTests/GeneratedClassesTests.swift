#if TEST_MODEL

import CoreData
import Foundation
import Nimble
import XCTest

final class GeneratedCodeTests: XCTestCase {

    private var managedObjectContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        let modelURL = url(forResource: "TypesModel", ofType: "momd")
        let model = NSManagedObjectModel(contentsOf: modelURL)!
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        try coordinator.addPersistentStore(ofType: NSInMemoryStoreType,
                                           configurationName: nil,
                                           at: nil,
                                           options: nil)
        managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
    }

    func testNonScalarAttributes() throws {
        let types = NSEntityDescription.insertNewObject(
            forEntityName: AllTypesClass.entityName,
            into: managedObjectContext
        ) as! AllTypesClass

        types.int16 = 16
        types.int32 = 32
        types.int64 = 64
        types.boolean = false
        types.decimal = NSDecimalNumber(value: 100)
        types.float = 1.2
        types.double = 3.4
        types.string = "all types"
        let now = NSDate()
        types.date = now

        let scalarTypes = NSEntityDescription.insertNewObject(forEntityName: "ScalarTypes", into: managedObjectContext) as! ScalarTypesClass
        scalarTypes.boolean = true
        types.scalars = scalarTypes

        try managedObjectContext.save()
        expect(types.int16) == 16
        expect(types.int32) == 32
        expect(types.int64) == 64
        expect(types.boolean!.boolValue) == false
        expect(types.decimal) == NSDecimalNumber(value: 100)
        expect(types.float!.floatValue).to(beCloseTo(1.2))
        expect(types.double!.doubleValue).to(beCloseTo(3.4))
        expect(types.string) == "all types"
        expect(types.date) == now
    }

    func testScalarAttributes() throws {
        let scalarTypes = NSEntityDescription.insertNewObject(
            forEntityName: ScalarTypesClass.entityName,
            into: managedObjectContext
        ) as! ScalarTypesClass

        let numericTypes = NSEntityDescription.insertNewObject(
            forEntityName: NumericTypesClass.entityName,
            into: managedObjectContext
        ) as! NumericTypesClass

        numericTypes.boolean = true
        scalarTypes.numerics = numericTypes
        scalarTypes.int16 = 2
        scalarTypes.int32 = 4
        scalarTypes.int64 = 8
        scalarTypes.boolean = false
        scalarTypes.float = 5.6
        scalarTypes.double = 7.8
        try managedObjectContext.save()
        expect(scalarTypes.int16) == 2
        expect(scalarTypes.int32) == 4
        expect(scalarTypes.int64) == 8
        expect(scalarTypes.boolean) == false
        expect(scalarTypes.float).to(beCloseTo(5.6))
        expect(scalarTypes.double).to(beCloseTo(7.8))
    }

    func testGeneratedNames() throws {
        let scalarTypes = NSEntityDescription.insertNewObject(
            forEntityName: CoreDataEntity.ScalarTypes.name,
            into: managedObjectContext
        )

        let allTypes = NSEntityDescription.insertNewObject(
            forEntityName: CoreDataEntity.AllTypes.name,
            into: managedObjectContext
        )

        scalarTypes.setValue(allTypes, forKey: CoreDataEntity.ScalarTypes.Field.numerics)
        scalarTypes.setValue(2, forKey: CoreDataEntity.ScalarTypes.Field.int16)
        scalarTypes.setValue(4, forKey: CoreDataEntity.ScalarTypes.Field.int32)
        scalarTypes.setValue(8, forKey: CoreDataEntity.ScalarTypes.Field.int64)
        scalarTypes.setValue(false, forKey: CoreDataEntity.ScalarTypes.Field.boolean)
        scalarTypes.setValue(5.6, forKey: CoreDataEntity.ScalarTypes.Field.float)
        scalarTypes.setValue(7.8, forKey: CoreDataEntity.ScalarTypes.Field.double)
        allTypes.setValue(9.1, forKey: CoreDataEntity.AllTypes.Field.double)
        try managedObjectContext.save()
        expect(scalarTypes.value(forKey: CoreDataEntity.ScalarTypes.Field.int16) as? Int) == 2
        expect(scalarTypes.value(forKey: CoreDataEntity.ScalarTypes.Field.int32) as? Int) == 4
        expect(scalarTypes.value(forKey: CoreDataEntity.ScalarTypes.Field.int64) as? Int) == 8
        expect(scalarTypes.value(forKey: CoreDataEntity.ScalarTypes.Field.boolean) as? Bool) == false
        expect(scalarTypes.value(forKey: CoreDataEntity.ScalarTypes.Field.float) as? Float).to(beCloseTo(5.6))
        expect(scalarTypes.value(forKey: CoreDataEntity.ScalarTypes.Field.double) as? Double).to(beCloseTo(7.8))
        expect(allTypes.value(forKey: CoreDataEntity.AllTypes.Field.double) as? Double).to(beCloseTo(9.1))
    }

    func testRelationships() throws {
        let types = NSEntityDescription.insertNewObject(
            forEntityName: AllTypesClass.entityName,
            into: managedObjectContext
        ) as! AllTypesClass

        let property1 = NSEntityDescription.insertNewObject(
            forEntityName: CoreDataEntity.Property.name,
            into: managedObjectContext
        ) as! PropertyClass

        property1.name = "name1"
        property1.value = "value1"
        types.addToProperties(property1)
        expect(types.properties) == NSSet(object: property1)

        let property2 = NSEntityDescription.insertNewObject(
            forEntityName: CoreDataEntity.Property.name,
            into: managedObjectContext
        ) as! PropertyClass
        property1.name = "name2"
        property1.value = "value2"

        let property3 = NSEntityDescription.insertNewObject(
            forEntityName: CoreDataEntity.Property.name,
            into: managedObjectContext
        ) as! PropertyClass
        property1.name = "name3"
        property1.value = "value3"
        types.addToProperties(NSSet(array: [property2, property3]))

        expect(types.properties) == NSSet(array: [property1, property2, property3])

        types.removeFromProperties(property2)
        expect(types.properties) == NSSet(array: [property1, property3])

        types.removeFromProperties(NSSet(array: [property1, property3]))
        expect(types.properties.count) == 0
    }
}

#endif
