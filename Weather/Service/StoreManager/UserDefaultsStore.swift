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
    
    func loadCitiesFromStore(complete: @escaping ([City]) -> Void) {
        if let storeCitiesData = UserDefaults.standard.object(forKey: userDefaultsCitiesKey) as? Data,
           let storeCities = try? JSONDecoder().decode([StoreCity].self, from: storeCitiesData) {
            let cities = storeCities.map() { City(storeCity: $0) }
            complete(cities)
        }
        complete([])
    }
    
    func saveToStore(_ cities: [City]) {
        let storeCity = cities.map() { StoreCity(name: $0.name, sortedNumber: $0.sortedNumber, latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude) }
        do {
            let objectCities = try JSONEncoder().encode(storeCity)
            UserDefaults.standard.set(objectCities,forKey: userDefaultsCitiesKey)
        } catch {
            print("Erorr encode for write to store")
        }
    }
}
