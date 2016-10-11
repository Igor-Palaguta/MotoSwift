import Foundation
import CoreData

enum NumericTypesClassAttributes: String {
   case boolean
   case decimal
   case double
   case float
   case int16
   case int32
   case int64
}

enum NumericTypesClassRelationships: String {
   case scalars
}


class _NumericTypesClass: NSManagedObject {
   class var entityName: String {
      return "NumericTypes"
   }

   @NSManaged var boolean: NSNumber?
   @NSManaged var decimal: NSDecimalNumber?
   @NSManaged var double: NSNumber?
   @NSManaged var float: NSNumber?
   @NSManaged var int16: NSNumber?
   @NSManaged var int32: NSNumber?
   @NSManaged var int64: NSNumber?

   @NSManaged var scalars: ScalarTypesClass
}
