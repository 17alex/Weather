//
//  MainInteractorTest.swift
//  WeatherTests
//
//  Created by Alex on 04.12.2020.
//

import XCTest
import CoreLocation

@testable import Weather

class MockNetworkManager: NetworkManagerProtocol {

    let testTimeInterval: TimeInterval = 1
    let fact = Fact(
        temp: 11,
        icon: "22",
        condition: "33",
        windSpeed: 44.0,
        windDir: "55",
        pressureMm: 66,
        humidity: 77)
    let part = Part(
        partName: "1111",
        tempMin: 2222,
        tempMax: 3333,
        tempAvg: 4444,
        icon: "5555",
        condition: "6666",
        windSpeed: 7777.0,
        windGust: 8888.0,
        windDir: "9999",
        pressureMm: 1234,
        humidity: 5678)
    lazy var forecast = Forecast(
        date: "111",
        week: 222,
        sunrise: "333",
        sunset: "444",
        moonCode: 555,
        parts: [part])
    lazy var testServerWeather = ServerWeather(
        now: testTimeInterval,
        fact: fact,
        forecast: forecast)
    
    var location: CLLocationCoordinate2D!
    
    func getWeather(location: CLLocationCoordinate2D, complete: @escaping (Result<ServerWeather, Error>) -> Void) {
        self.location = location
        complete(.success(testServerWeather))
    }
    
    
}

class MockStoreManager: StoreManagerProtocol {
    
    var storeCities = [
        City(name: "StoreCity", coordinate: CLLocationCoordinate2D(latitude: 12345, longitude: 67890))
    ]
    
    func loadCitiesFromStore() -> [City] {
        return storeCities
    }
    
    func saveToStore(_ cities: [City]) {
        storeCities = cities
    }
}

class MockLocationManager: LocationManagerProtocol {
    
    let testLocation = CLLocationCoordinate2D(latitude: 2211, longitude: 4433)
    
    func getLocation(for cityName: String, complete: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        complete(.success(testLocation))
    }
    
}

class MockMainPresenter: MainInteractorOutput {
    
    var testCity: City!
    
    func didUpdate(for city: City) {
        testCity = city
    }
    
    func didAdd(newCity: City) {
        
    }
    
    func notFindLocation(for cityName: String, error: Error) {
        
    }
    
    func didFindDublicate(city: City) {
        
    }
}

class MainInteractorTest: XCTestCase {
    
    var networkManager: MockNetworkManager!
    var storeManager: MockStoreManager!
    var locationManager: MockLocationManager!
    var interactor: MainInteractor!
    var presenter: MockMainPresenter!

    override func setUpWithError() throws {
        
        networkManager = MockNetworkManager()
        storeManager = MockStoreManager()
        locationManager = MockLocationManager()
        interactor = MainInteractor()
        interactor.networkManager = networkManager
        interactor.storeManager = storeManager
        interactor.locationManager = locationManager
        presenter = MockMainPresenter()
        interactor.presenter = presenter
    }

    override func tearDownWithError() throws {
        networkManager = nil
        storeManager = nil
        locationManager = nil
        presenter = nil
        interactor = nil
    }


    func testLoadWeather() {
        XCTAssertEqual(interactor.citiesWeather.count, 0)
        let testCity = City(name: "TestCityName", coordinate: CLLocationCoordinate2D(latitude: 66, longitude: 77))
        interactor.loadWeather(for: testCity)
        XCTAssertEqual(interactor.citiesWeather.count, 1)
        XCTAssertEqual(presenter.testCity, testCity)
        XCTAssertEqual(networkManager.testServerWeather.now, interactor.citiesWeather[testCity.name]!.serverWeather!.now)
    }

    func testFindLocation() {
        
        interactor.findLocation(forCityName: "testCityName")
        XCTAssertEqual(locationManager.testLocation.latitude, interactor.citiesForScreen.first!.coordinate.latitude)
        XCTAssertEqual(locationManager.testLocation.longitude, interactor.citiesForScreen.first!.coordinate.longitude)
    }
}
