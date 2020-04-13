// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to properties.stencil instead.

import CoreData
import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length
// swiftlint:disable type_body_length
// swiftlint:disable trailing_newline
// swiftlint:disable implicit_return
extension NumericTypesClass {
   @objc public class var entityName: String {
      return "NumericTypes"
   }

   @nonobjc
   public class func fetchRequest() -> NSFetchRequest<NumericTypesClass> {
       return NSFetchRequest<NumericTypesClass>(entityName: entityName)
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

