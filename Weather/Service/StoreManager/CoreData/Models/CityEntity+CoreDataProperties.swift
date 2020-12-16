//
//  CityEntity+CoreDataProperties.swift
//  Weather
//
//  Created by Alex on 09.12.2020.
//
//

import Foundation
import CoreData


extension CityEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityEntity> {
        return NSFetchRequest<CityEntity>(entityName: "CityEntity")
    }

    @NSManaged public var name: String
    @NSManaged public var sortedNumber: Int16
    @NSManaged public var coordinate: CoordinateEntity

}

extension CityEntity : Identifiable {

}
