// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to properties.stencil instead.

import Foundation
import CoreData

// swiftlint:disable file_length
// swiftlint:disable type_body_length
extension ScalarTypesClass {
   public class var entityName: String {
      return "ScalarTypes"
   }

   @nonobjc public class func fetchRequest() -> NSFetchRequest<ScalarTypesClass> {
       return NSFetchRequest<ScalarTypesClass>(entityName: self.entityName)
   }

   @NSManaged public var boolean: Bool
   @NSManaged public var double: Double
   @NSManaged public var float: Float
   @NSManaged public var int16: Int16
   @NSManaged public var int32: Int32
   @NSManaged public var int64: Int64

   @NSManaged public var numerics: NumericTypesClass
}
