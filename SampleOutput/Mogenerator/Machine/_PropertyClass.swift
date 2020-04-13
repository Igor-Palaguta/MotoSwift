// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to machine.stencil instead.

import CoreData
import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length
// swiftlint:disable type_body_length
// swiftlint:disable vertical_whitespace
// swiftlint:disable implicit_return
public enum PropertyClassAttributes: String {
    case name
    case value
}

public enum PropertyClassRelationships: String {
    case types
}


// swiftlint:disable type_name
public class _PropertyClass: NSManagedObject {
    @objc public class var entityName: String {
        return "Property"
    }

    @NSManaged public var name: String
    @NSManaged public var value: String

    @NSManaged public var types: AllTypesClass?
}
