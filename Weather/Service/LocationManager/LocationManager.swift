//
//  LocationManager.swift
//  Weather
//


import Foundation
import CoreLocation

class LocationManager {
    private func onMain(_ blok: @escaping (() -> Void)) {
        DispatchQueue.main.async {
            blok()
        }
    }
}

//MARK: - LocationManagerProtocol

extension LocationManager: LocationManagerProtocol {
    func getLocation(for cityName: String, complete: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        CLGeocoder().geocodeAddressString(cityName) { (placemark, error) in
            if let cityCoordinate = placemark?.first?.location?.coordinate {
                self.onMain { complete(.success(cityCoordinate)) }
            } else if let error = error {
                self.onMain { complete(.failure(error)) }
            }
        }
    }
}
