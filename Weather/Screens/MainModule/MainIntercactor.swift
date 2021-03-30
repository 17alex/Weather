//
//  MainIntercactor.swift
//  Weather
//
//  Created by Alex on 30.11.2020.
//

import Foundation
import CoreLocation

protocol MainInteractorInput {
    var citiesForScreen: [City] { get }
    var citiesWeather: [String: WeatherModel] { get }
    func start()
    func add(new cityName: String, coordinate: CLLocationCoordinate2D)
    func renameCity(from oldName: String, to newName: String)
    func reorderCity(at fromIndex: Int, to toIndex: Int)
    func removeCity(at index: Int)
    func searchCity(with text: String)
    func findLocation(forCityName cityName: String)
    func changeCoordinate(for city: City)
    func loadWeather(for city: City)
}

class MainInteractor {
    
    //MARK: - Propertis
    
    var networkManager: NetworkManagerProtocol!
    var locationManager: LocationManagerProtocol!
    var storeManager: StoreManagerProtocol!
    unowned var presenter: MainInteractorOutput!
    
    private var cities: [City] = []
    private var searchCities: [City] = []
    var citiesWeather: [String: WeatherModel] = [:]
    private var searchText: String = ""
    
    private var nextSortedNumber: Int16 {
        return Int16(cities.count)
    }
    
    var citiesForScreen: [City] {
        if isSearch { return searchCities }
        else { return cities }
    }
    
    private var isSearch: Bool {
        if searchText == "" { return false }
        else { return true }
    }
}

//MARK: - MainInteractorInput

extension MainInteractor: MainInteractorInput {
    
    func start() {
        storeManager.loadCitiesFromStore { self.cities = $0 }
        citiesWeather = [:]
    }
    
    func add(new cityName: String, coordinate: CLLocationCoordinate2D) {
        let city = City(name: cityName, sortedNumber: nextSortedNumber, coordinate: coordinate)
        if cities.contains(city) {
            presenter.didAlreadyExists(city: city)
        } else {
            cities.append(city)
            storeManager.saveToStore(cities)
            presenter.didAdd(newCity: city)
        }
    }
    
    func renameCity(from oldName: String, to newName: String) {
        if let index = cities.firstIndex(where: { $0.name == oldName }) {
            cities[index].name = newName
            storeManager.saveToStore(cities)
            presenter.didUpdate(for: cities[index])
        }
    }
    
    func reorderCity(at fromIndex: Int, to toIndex: Int) {
        cities.insert(cities.remove(at: fromIndex), at: toIndex)
        for index in 0..<cities.count {
            cities[index].sortedNumber = Int16(index)
        }
        storeManager.saveToStore(cities)
    }
    
    func removeCity(at index: Int) {
        var city: City!
        if isSearch {
            city = searchCities.remove(at: index)
            cities.remove(at: cities.firstIndex(of: city)!)
        } else {
            city = cities.remove(at: index)
        }
        citiesWeather.removeValue(forKey: city.name)
        storeManager.saveToStore(cities)
    }
    
    func searchCity(with text: String) {
        self.searchText = text
        searchCities = cities.filter() { $0.name.lowercased().contains(text.lowercased()) }
    }
    
    func findLocation(forCityName cityName: String) {
        locationManager.getLocation(for: cityName) { (result) in
            switch result {
            case .success(let locaton):
                self.add(new: cityName, coordinate: locaton)
            case .failure(let error):
                self.presenter.didNotFindLocation(for: cityName, error: error)
            }
        }
    }
    
    func changeCoordinate(for city: City) {
        let index = cities.firstIndex(of: city)!
        cities[index] = city
        storeManager.saveToStore(cities)
    }
    
    func loadWeather(for city: City) {
        self.networkManager.getWeather(location: city.coordinate) { (result) in
            switch result {
            case .failure(let serverError):   self.citiesWeather[city.name] = WeatherModel(serverWeather: nil, loadError: serverError)
            case .success(let serverWeather): self.citiesWeather[city.name] = WeatherModel(serverWeather: serverWeather, loadError: nil)
            }
            self.presenter.didUpdate(for: city)
        }
    }
}
