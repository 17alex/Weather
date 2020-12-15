//
//  LocationManagerProtocol.swift
//  Weather
//
//  Created by Alex on 10.12.2020.
//

import Foundation
import CoreLocation

protocol LocationManagerProtocol {
    func getLocation(for cityName: String, complete: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void)
}
