//
//  RealmStore.swift
//  Weather
//
//  Created by Alex on 16.12.2020.
//

import Foundation
import RealmSwift
import CoreLocation

class RealmStore {
    
    let realm = try! Realm()
    
    //MARK: - Metods
    
//    private func add(cities: [City]) {
//
//    }
    
//    private func deleteAllCities() {
//        let citiesRealm = realm.objects(CityRealm.self)
//        try! realm.write { realm.delete(citiesRealm) }
//    }
}

//MARK: - StoreManagerProtocol

extension RealmStore: StoreManagerProtocol {
    
    func loadCitiesFromStore(complete: @escaping ([City]) -> Void) {
        let citiesRealm = realm.objects(CityRealm.self).sorted(byKeyPath: #keyPath(CityRealm.sortedNumber), ascending: true)
        let cities: [City] = citiesRealm.map {
            return City(name: $0.name,
                        sortedNumber: $0.sortedNumber,
                        coordinate: CLLocationCoordinate2D(
                            latitude: $0.coordinate!.latitude,
                            longitude: $0.coordinate!.longitude)
            )
        }
        complete(cities)
    }
    
    func saveToStore(_ cities: [City]) {
        try! realm.write { realm.deleteAll() }
        
        let citiesRealm: [CityRealm] = cities.map {
            let cityRealm = CityRealm()
            cityRealm.name = $0.name
            cityRealm.sortedNumber = $0.sortedNumber
            cityRealm.coordinate?.latitude = $0.coordinate.latitude
            cityRealm.coordinate?.longitude = $0.coordinate.longitude
            return cityRealm
        }
        
        try! realm.write { realm.add(citiesRealm) }
    }
}
