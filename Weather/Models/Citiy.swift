//
//  Cities.swift
//  Weather
//
//  Created by Alex on 24.11.2020.
//

import Foundation
import CoreLocation
import CoreData

struct City {
    var name: String
    var sortedNumber: Int16
    var coordinate: CLLocationCoordinate2D
    
    init(name: String, sortedNumber: Int16, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.coordinate = coordinate
        self.sortedNumber = sortedNumber
    }
    
    init(cityEntity: CityEntity) {
        self.name = cityEntity.name
        self.coordinate = CLLocationCoordinate2D(latitude: cityEntity.coordinate.latitude, longitude: cityEntity.coordinate.longitude)
        self.sortedNumber = cityEntity.sortedNumber
    }
    
    init(storeCity: StoreCity) {
        self.name = storeCity.name
        self.coordinate = CLLocationCoordinate2D(latitude: storeCity.latitude, longitude: storeCity.longitude)
        self.sortedNumber = storeCity.sortedNumber
    }
}

extension City: Equatable {
    static func == (lhs: City, rhs: City) -> Bool {
        lhs.name == rhs.name
    }
}
