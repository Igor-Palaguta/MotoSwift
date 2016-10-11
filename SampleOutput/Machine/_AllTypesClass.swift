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
