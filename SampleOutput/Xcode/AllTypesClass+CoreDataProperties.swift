// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to properties.stencil instead.

import CoreData
import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length
// swiftlint:disable type_body_length
// swiftlint:disable trailing_newline
// swiftlint:disable implicit_return
extension AllTypesClass {
    @objc override public class var entityName: String {
        return "AllTypes"
    }

    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<AllTypesClass> {
        return NSFetchRequest<AllTypesClass>(entityName: entityName)
    }

    @NSManaged public var data: NSData?
    @NSManaged public var date: NSDate?
    @NSManaged public var string: String?
    @NSManaged public var transformable: NSObject?
    @NSManaged public var properties: NSSet
}

extension AllTypesClass {

    @objc(addPropertiesObject:)
    @NSManaged public func addToProperties(_ value: PropertyClass)

    @objc(removePropertiesObject:)
    @NSManaged public func removeFromProperties(_ value: PropertyClass)

    @objc(addProperties:)
    @NSManaged public func addToProperties(_ values: NSSet)

    @objc(removeProperties:)
    @NSManaged public func removeFromProperties(_ values: NSSet)
}
