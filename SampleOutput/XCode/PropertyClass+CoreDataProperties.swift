// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to properties.stencil instead.

import CoreData
import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length
// swiftlint:disable type_body_length
// swiftlint:disable trailing_newline
extension PropertyClass {
   @nonobjc
   public class func fetchRequest() -> NSFetchRequest<PropertyClass> {
       return NSFetchRequest<PropertyClass>(entityName: self.entityName)
   }

   @NSManaged public var name: String
   @NSManaged public var value: String
   @NSManaged public var types: AllTypesClass?
}

