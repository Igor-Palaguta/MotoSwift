//
//  AllTypesClass+CoreDataProperties.swift
//  
//
//  Created by Igor Palaguta on 10.10.16.
//
//

import Foundation
import CoreData


extension AllTypesClass {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AllTypesClass> {
        return NSFetchRequest<AllTypesClass>(entityName: "AllTypes");
    }

    @NSManaged public var data: NSData?
    @NSManaged public var date: NSDate?
    @NSManaged public var string: String?
    @NSManaged public var transformable: NSObject?

}
