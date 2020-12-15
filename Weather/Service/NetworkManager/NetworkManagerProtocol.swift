//
//  NetworkManagerProtocol.swift
//  Weather
//
//  Created by Alex on 10.12.2020.
//

import Foundation
import CoreLocation

protocol NetworkManagerProtocol {
    func getWeather(location: CLLocationCoordinate2D, complete: @escaping (Result<ServerWeather, Error>) -> Void)
}
