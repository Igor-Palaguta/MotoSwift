// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to machine.stencil instead.

import Foundation
import CoreData

// swiftlint:disable file_length
// swiftlint:disable type_body_length
public enum AllTypesClassAttributes: String {
   case data
   case date
   case string
   case transformable
}



// swiftlint:disable type_name
public class _AllTypesClass: NumericTypesClass {
   public override class var entityName: String {
      return "AllTypes"
   }

   @NSManaged public var data: NSData?
   @NSManaged public var date: NSDate?
   @NSManaged public var string: String?
   @NSManaged public var transformable: NSObject?

}
