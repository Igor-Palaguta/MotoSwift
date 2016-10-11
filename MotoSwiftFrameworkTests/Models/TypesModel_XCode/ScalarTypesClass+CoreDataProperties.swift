//
//  ScalarTypesClass+CoreDataProperties.swift
//  
//
//  Created by Igor Palaguta on 10.10.16.
//
//

import Foundation
import CoreData


extension ScalarTypesClass {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScalarTypesClass> {
        return NSFetchRequest<ScalarTypesClass>(entityName: "ScalarTypes");
    }

    @NSManaged public var boolean: Bool
    @NSManaged public var decimal: NSDecimalNumber?
    @NSManaged public var double: Double
    @NSManaged public var float: Float
    @NSManaged public var int16: Int16
    @NSManaged public var int32: Int32
    @NSManaged public var int64: Int64
    @NSManaged public var numerics: NumericTypesClass?

}
