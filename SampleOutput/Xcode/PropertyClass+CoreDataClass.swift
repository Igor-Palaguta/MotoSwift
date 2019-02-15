import CoreData
import Foundation

@objc(PropertyClass)
public class PropertyClass: NSManagedObject {
   public class var entityName: String {
      return "Property"
   }
}
