import Foundation
import CoreData

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


public class _NumericTypesClass: NSManagedObject {
   public class var entityName: String {
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
