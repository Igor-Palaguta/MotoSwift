import Foundation
import CoreData

enum ScalarTypesClassAttributes: String {
   case boolean
   case double
   case float
   case int16
   case int32
   case int64
}

enum ScalarTypesClassRelationships: String {
   case numerics
}

enum ScalarTypesClassFetchedProperties: String {
   case eq_true
   case gt_100

   var predicateString: String {
      switch self {
      case .eq_true:
         return "boolean == YES"
      case .gt_100:
         return "int16 > 100"
      }
   }

   var entityName: String {
      switch self {
      case .eq_true:
         return "ScalarTypes"
      case .gt_100:
         return "ScalarTypes"
      }
   }
}

class _ScalarTypesClass: NSManagedObject {
   class var entityName: String {
      return "ScalarTypes"
   }

   @NSManaged var boolean: Bool
   @NSManaged var double: Double
   @NSManaged var float: Float
   @NSManaged var int16: Int16
   @NSManaged var int32: Int32
   @NSManaged var int64: Int64

   @NSManaged var numerics: NumericTypesClass
}
