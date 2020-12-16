//
//  StoreManager.swift
//  Weather
//


import Foundation
import CoreLocation

class UserDefaultsStore {
    let userDefaultsCitiesKey = "Cities"
}

//MARK: - StoreManagerProtocol

extension UserDefaultsStore: StoreManagerProtocol {
    
    func saveToStore(_ cities: [City]) {
        let userDefaultsCities = cities.map {
            UserDefaultsCity(name: $0.name,
                             sortedNumber: $0.sortedNumber,
                             latitude: $0.coordinate.latitude,
                             longitude: $0.coordinate.longitude
            )
        }
        do {
            let objectCities = try JSONEncoder().encode(userDefaultsCities)
            UserDefaults.standard.set(objectCities,forKey: userDefaultsCitiesKey)
        } catch {
            print("Erorr encode for write to store")
        }
    }
    
    func loadCitiesFromStore(complete: @escaping ([City]) -> Void) {
        if let userDefaultsCitiesData = UserDefaults.standard.object(forKey: userDefaultsCitiesKey) as? Data,
           let userDefaultsCities = try? JSONDecoder().decode([UserDefaultsCity].self, from: userDefaultsCitiesData) {
            let cities: [City] = userDefaultsCities.map {
                City(name: $0.name,
                     sortedNumber: $0.sortedNumber,
                     coordinate: CLLocationCoordinate2D(
                        latitude: $0.latitude,
                        longitude: $0.longitude)
                )
            }
            complete(cities)
        }
        complete([])
    }
    
    
}
