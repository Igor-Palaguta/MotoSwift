// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to machine.stencil instead.

import CoreData
import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length
// swiftlint:disable type_body_length
// swiftlint:disable vertical_whitespace
// swiftlint:disable implicit_return
public enum AllTypesClassAttributes: String {
   case data
   case date
   case string
   case transformable
}

public enum AllTypesClassRelationships: String {
   case properties
}


// swiftlint:disable type_name
public class _AllTypesClass: NumericTypesClass {
   @objc override public class var entityName: String {
      return "AllTypes"
   }

   @NSManaged public var data: NSData?
   @NSManaged public var date: NSDate?
   @NSManaged public var string: String?
   @NSManaged public var transformable: NSObject?

   @NSManaged public var properties: NSSet
}
