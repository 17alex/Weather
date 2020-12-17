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
            print("name: \($0.name), sortedNumber: \($0.sortedNumber), latitude: \($0.coordinate?.latitude), longitude: \($0.coordinate?.longitude)")
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
        cities.forEach { city in
            let cityRealm = CityRealm()
            cityRealm.name = city.name
            cityRealm.sortedNumber = city.sortedNumber
            cityRealm.coordinate?.latitude = city.coordinate.latitude
            cityRealm.coordinate?.longitude = city.coordinate.longitude
            try! realm.write {
                realm.add(cityRealm)
            }
        }
    }
    
//    func loadCitiesFromStore(complete: @escaping ([City]) -> Void) {
//        let citiesRealm = realm.objects(CityRealm.self).sorted(byKeyPath: #keyPath(CityRealm.sortedNumber), ascending: true)
//        let cities: [City] = citiesRealm.map {
//            City(name: $0.name,
//                 sortedNumber: $0.sortedNumber,
//                 coordinate: CLLocationCoordinate2D(
//                    latitude: $0.latitude,
//                    longitude: $0.longitude)
//            )
//        }
//        complete(cities)
//    }
//
//    func saveToStore(_ cities: [City]) {
//        realm.deleteAll()
//        cities.forEach { city in
//            let cityRealm = CityRealm()
//            cityRealm.name = city.name
//            cityRealm.sortedNumber = city.sortedNumber
//            cityRealm.latitude = city.coordinate.latitude
//            cityRealm.longitude = city.coordinate.longitude
//            try! realm.write {
//                realm.add(cityRealm)
//            }
//        }
//    }
}
