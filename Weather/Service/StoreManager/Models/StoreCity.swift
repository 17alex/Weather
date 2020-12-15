//
//  StoreCity.swift
//  Weather
//
//  Created by Alex on 10.12.2020.
//

import Foundation

struct StoreCity: Codable {
    let name: String
    let sortedNumber: Int16
    let latitude: Double
    let longitude: Double
}
