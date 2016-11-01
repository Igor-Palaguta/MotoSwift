// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to properties.stencil instead.

import Foundation
import CoreData

// swiftlint:disable file_length
// swiftlint:disable type_body_length
extension AllTypesClass {
   public override class var entityName: String {
      return "AllTypes"
   }

   @nonobjc public class func fetchRequest() -> NSFetchRequest<AllTypesClass> {
       return NSFetchRequest<AllTypesClass>(entityName: self.entityName)
   }

   @NSManaged public var data: NSData?
   @NSManaged public var date: NSDate?
   @NSManaged public var string: String?
   @NSManaged public var transformable: NSObject?

}
