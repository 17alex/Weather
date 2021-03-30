//
//  MainPresenterTest.swift
//  WeatherTests
//
//  Created by Alex on 19.11.2020.
//

import XCTest
import CoreLocation

@testable import Weather

class MockView: MainViewInput {
    
    var updateIndex: Int?
    var index: Int?
    var showAlert = false
    var cityName = ""
    var error: Error = ""
    var boolVar: Bool = false
    
    func updateWeather(forRow index: Int) {
        updateIndex = index
    }
    
    func addRow(at index: Int) {
        self.index = index
    }
    
    func update(forRow index: Int) {
        self.index = index
    }
    
    func showAlertForEnterNewCity() {
        showAlert = true
    }
    
    func showAlertNotLocationFor(cityName: String, error: Error) {
        self.cityName = cityName
        self.error = error
    }
    
    func showAlertForReaname(cityName: String) {
        self.cityName = cityName
    }
    
    func showAlertEnterDublicate(cityName: String) {
        self.cityName = cityName
    }
    
    func showAlertAlreadyExists(cityName: String) {
        self.cityName = cityName
    }
    
    func activityIndicator(animate: Bool) {
        boolVar = animate
    }
}

class MockMainRouter: MainRouterProtocol {
    
    
    var city: String?
    var weatherModel: WeatherModel?
    
    func showDetailWeather(forCity city: String, weatherModel: WeatherModel?) {
        self.city = city
        self.weatherModel = weatherModel
    }
    
    func showDetailWeather(for city: City, weatherModel: WeatherModel?, delegate: DetailPresenterDelegate?) {
        
    }
    
    func showMap(for cityName: String, changeCoordinateCallback: @escaping (CLLocationCoordinate2D) -> Void) {
        
    }
    
    func dismiss() {
        
    }
}

class MockInteractor: MainInteractorInput {
    
    var citiesForScreen: [City] = []
    var citiesWeather: [String : WeatherModel] = [:]
    
    var addCity: City!
    
    func start() {
        
    }
    
    func add(new cityName: String, coordinate: CLLocationCoordinate2D) {
        
    }
    
    func reorderCity(at fromIndex: Int, to toIndex: Int) {
        
    }
    
    func searchCity(with text: String) {
        
    }
    
    func add(new city: City) {
        self.addCity = city
    }
    
    func renameCity(from oldName: String, to newName: String) {
        
    }
    
    func moveCity(at fromIndex: Int, to toIndex: Int) {
        
    }
    
    func removeCity(at index: Int) {
        
    }
    
    func search(text: String) {
        
    }
    
    func findLocation(forCityName cityName: String) {
        
    }
    
    func changeCoordinate(for city: City) {
        
    }
    
    func loadWeather(for city: City) {
        let fact = Fact(temp: 1,
                        icon: "icon",
                        condition: "condition",
                        windSpeed: 2.2,
                        windDir: "windDir",
                        pressureMm: 333,
                        humidity: 444)
        let part = Part(partName: "partName",
                        tempMin: 7,
                        tempMax: 8,
                        tempAvg: 9,
                        icon: "partIcon",
                        condition: "partCondition",
                        windSpeed: 10.0,
                        windGust: 11.0,
                        windDir: "e",
                        pressureMm: 12,
                        humidity: 13)
        let forecast = Forecast(date: "date",
                                week: 5,
                                sunrise: "sunrise",
                                sunset: "sunset",
                                moonCode: 6,
                                parts: [part])
        
        let serverWeather = ServerWeather(now: 0, fact: fact, forecast: forecast)
        let testWeatherModel = WeatherModel(serverWeather: serverWeather, loadError: nil)
        citiesWeather[city.name] = testWeatherModel
    }
}

class MainPresenterTest: XCTestCase {
    var view: MockView!
    var presenter: MainPresenter!
    var interactor: MockInteractor!
    var router: MockMainRouter!

    override func setUp() {
        router = MockMainRouter()
        interactor = MockInteractor()
        presenter = MainPresenter(interactor: interactor)
        view = MockView()
        presenter.view = view
    }
    
    override func tearDown() {
        view = nil
        presenter = nil
        router = nil
        interactor = nil
    }
    
    func testDidAdd() {
        let testCity1 = City(name: "Moscow", sortedNumber: 0, coordinate: CLLocationCoordinate2D(latitude: 11, longitude: 22))
        let testCity2 = City(name: "Piter", sortedNumber: 1, coordinate: CLLocationCoordinate2D(latitude: 33, longitude: 44))
        interactor.citiesForScreen = [testCity1, testCity2]
        let testIndex = 1
        presenter.didAdd(newCity: interactor.citiesForScreen[testIndex])
        XCTAssertEqual(testIndex, view.index)
    }
    
    func testDidUpdate() {
        let testCity1 = City(name: "Moscow", sortedNumber: 0, coordinate: CLLocationCoordinate2D(latitude: 11, longitude: 22))
        let testCity2 = City(name: "Piter", sortedNumber: 1, coordinate: CLLocationCoordinate2D(latitude: 33, longitude: 44))
        interactor.citiesForScreen = [testCity1, testCity2]
        let testIndex = 1
        presenter.didUpdate(for: interactor.citiesForScreen[testIndex])
        XCTAssertEqual(testIndex, view.index)
    }
    
    func testNotFindLocation() {
        let testCityName = "TestName"
        let testError: Error = "TestError"
        presenter.didNotFindLocation(for: testCityName, error: testError)
        XCTAssertEqual(testCityName, view.cityName)
    }
}
