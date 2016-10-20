import Foundation
import CoreData

public enum ScalarTypesClassAttributes: String {
   case boolean
   case double
   case float
   case int16
   case int32
   case int64
}

public enum ScalarTypesClassRelationships: String {
   case numerics
}

public enum ScalarTypesClassFetchedProperties: String {
   case eq_true
   case gt_100

   public var predicateString: String {
      switch self {
      case .eq_true:
         return "boolean == YES"
      case .gt_100:
         return "int16 > 100"
      }
   }

   public var entityName: String {
      switch self {
      case .eq_true:
         return "ScalarTypes"
      case .gt_100:
         return "ScalarTypes"
      }
   }
}

public class _ScalarTypesClass: NSManagedObject {
   public class var entityName: String {
      return "ScalarTypes"
   }

   @NSManaged public var boolean: Bool
   @NSManaged public var double: Double
   @NSManaged public var float: Float
   @NSManaged public var int16: Int16
   @NSManaged public var int32: Int32
   @NSManaged public var int64: Int64

   @NSManaged public var numerics: NumericTypesClass
}
