import Foundation
import CoreData

enum AllTypesClassAttributes: String {
   case data
   case date
   case string
   case transformable
}





class _AllTypesClass: NumericTypesClass {
   override class var entityName: String {
      return "AllTypes"
   }

   @NSManaged var data: NSData?
   @NSManaged var date: NSDate?
   @NSManaged var string: String?
   @NSManaged var transformable: NSObject?


}

import Foundation

@objc(AllTypesClass)
class AllTypesClass: _AllTypesClass {
}

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

import Foundation

@objc(NumericTypesClass)
class NumericTypesClass: _NumericTypesClass {
}

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

import Foundation

@objc(ScalarTypesClass)
class ScalarTypesClass: _ScalarTypesClass {
}
