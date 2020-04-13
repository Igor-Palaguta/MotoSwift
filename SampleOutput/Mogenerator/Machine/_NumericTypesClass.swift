// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to machine.stencil instead.

import CoreData
import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length
// swiftlint:disable type_body_length
// swiftlint:disable vertical_whitespace
// swiftlint:disable implicit_return
public enum NumericTypesClassAttributes: String {
   case boolean
   case decimal
   case double
   case float
   case int16
   case int32
   case int64
}

public enum NumericTypesClassRelationships: String {
   case scalars
}


// swiftlint:disable type_name
public class _NumericTypesClass: NSManagedObject {
   @objc public class var entityName: String {
      return "NumericTypes"
   }

   @NSManaged public var boolean: NSNumber?
   @NSManaged public var decimal: NSDecimalNumber?
   @NSManaged public var double: NSNumber?
   @NSManaged public var float: NSNumber?
   @NSManaged public var int16: NSNumber?
   @NSManaged public var int32: NSNumber?
   @NSManaged public var int64: NSNumber?

   @NSManaged public var scalars: ScalarTypesClass
}
