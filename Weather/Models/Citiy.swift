//
//  Cities.swift
//  Weather
//
//  Created by Alex on 24.11.2020.
//

import Foundation
import CoreLocation

struct City {
    var name: String
    var sortedNumber: Int16
    var coordinate: CLLocationCoordinate2D

}

extension City: Equatable {
    static func == (lhs: City, rhs: City) -> Bool {
        lhs.name == rhs.name
    }
}
