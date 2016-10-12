import Foundation
import CoreData

public enum AllTypesClassAttributes: String {
   case data
   case date
   case string
   case transformable
}



public class _AllTypesClass: NumericTypesClass {
   public override class var entityName: String {
      return "AllTypes"
   }

   @NSManaged public var data: NSData?
   @NSManaged public var date: NSDate?
   @NSManaged public var string: String?
   @NSManaged public var transformable: NSObject?

}
