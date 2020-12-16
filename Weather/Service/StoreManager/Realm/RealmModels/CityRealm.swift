//
//  CityRealm.swift
//  Weather
//
//  Created by Alex on 16.12.2020.
//

import Foundation
import RealmSwift

class CityRealm: Object {
    @objc dynamic var name = ""
    @objc dynamic var sortedNumber: Int16 = 0
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
}
