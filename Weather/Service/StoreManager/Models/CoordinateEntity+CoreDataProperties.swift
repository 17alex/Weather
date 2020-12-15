//
//  CoordinateEntity+CoreDataProperties.swift
//  Weather
//
//  Created by Alex on 09.12.2020.
//
//

import Foundation
import CoreData


extension CoordinateEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoordinateEntity> {
        return NSFetchRequest<CoordinateEntity>(entityName: "CoordinateEntity")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var city: CityEntity?

}

extension CoordinateEntity : Identifiable {

}
