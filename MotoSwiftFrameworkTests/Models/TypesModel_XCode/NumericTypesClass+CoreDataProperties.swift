//
//  NumericTypesClass+CoreDataProperties.swift
//  
//
//  Created by Igor Palaguta on 10.10.16.
//
//

import Foundation
import CoreData


extension NumericTypesClass {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NumericTypesClass> {
        return NSFetchRequest<NumericTypesClass>(entityName: "NumericTypes");
    }

    @NSManaged public var boolean: NSNumber?
    @NSManaged public var decimal: NSDecimalNumber?
    @NSManaged public var double: NSNumber?
    @NSManaged public var float: NSNumber?
    @NSManaged public var int16: NSNumber?
    @NSManaged public var int32: NSNumber?
    @NSManaged public var int64: NSNumber?
    @NSManaged public var scalars: ScalarTypesClass?

}
