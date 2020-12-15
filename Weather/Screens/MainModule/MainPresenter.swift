//
//  WeatherPresenter.swift
//  Weather
//
//  Created by Alex on 03.11.2020.
//

import UIKit
import CoreLocation

protocol MainViewOutput {
    var citiesForScreen: [City] { get }
    func start()
    func searchCity(with text: String)
    func addCityButtonAction()
    func inMapButtonAction(for cityName: String)
    func renameCityAction(at index: Int)
    func pressToRow(at index: Int)
    func enterNew(cityName: String)
    func renameCity(from oldName: String, to newName: String)
    func reorderCity(at fromIndex: Int, to toIndex: Int)
    func removeCity(at index: Int)
    func getViewModelFor(index: Int) -> MainViewModel
}

protocol MainInteractorOutput: class {
    func didUpdate(for city: City)
    func didAdd(newCity: City)
    func notFindLocation(for cityName: String, error: Error)
    func didAlreadyExists(city: City)
}

class MainPresenter {
    
    //MARK: - Propertis
    
    var router: MainRouterProtocol!
    private let interactor: MainInteractorInput
    unowned var view: MainViewInput!
    
    //MARK: - Init
    
    init(interactor: MainInteractorInput) {
        self.interactor = interactor
    }
    
    //MARK: - Metods
    
    private func getWeather(for city: City) {
        interactor.loadWeather(for: city)
    }
    
    private func getViewModelFor(city: City) -> MainViewModel {
        let cityWeather = interactor.citiesWeather[city.name]
        if cityWeather == nil { getWeather(for: city) }
        let mainViewModel = MainViewModel(cityName: city.name, cityWeather: cityWeather)
        return mainViewModel
    }
}

//MARK: - MainViewOutput

extension MainPresenter: MainViewOutput {
    
    var citiesForScreen: [City] {
        interactor.citiesForScreen
    }
    
    func start() {
        interactor.start()
    }
    
    func pressToRow(at index: Int) {
        let city = citiesForScreen[index]
        let weatherModel = interactor.citiesWeather[city.name]
        router.showDetailWeather(for: city, weatherModel: weatherModel, delegate: self)
    }
    
    func inMapButtonAction(for cityName: String) {
        router.showMap(for: cityName) { (coordinate) in
            self.interactor.add(new: cityName, coordinate: coordinate)
        }
    }
    
    func addCityButtonAction() {
        view.showAlertForEnterNewCity()
    }
    
    func renameCityAction(at index: Int) {
        view.showAlertForReaname(cityName: citiesForScreen[index].name)
    }
    
    func renameCity(from oldName: String, to newName: String) {
        var newCityName = newName
        newCityName.capitalizeFirstLetter()
        interactor.renameCity(from: oldName, to: newCityName)
    }
    
    func reorderCity(at fromIndex: Int, to toIndex: Int) {
        interactor.reorderCity(at: fromIndex, to: toIndex)
    }
    
    func removeCity(at index: Int) {
        interactor.removeCity(at: index)
    }
    
    func getViewModelFor(index: Int) -> MainViewModel {
        let city = citiesForScreen[index]
        return getViewModelFor(city: city)
    }
    
    func searchCity(with text: String) {
        interactor.searchCity(with: text)
    }
    
    func enterNew(cityName: String) {
        view.activityIndicator(animate: true)
        var newCityName = cityName
        newCityName.capitalizeFirstLetter()
        interactor.findLocation(forCityName: newCityName)
    }
}

//MARK: - MainInteractorOutput

extension MainPresenter: MainInteractorOutput {
    
    func didUpdate(for city: City) {
        if let index = citiesForScreen.firstIndex(of: city) {
            view.update(forRow: index)
        }
    }
    
    func didAdd(newCity: City) {
        view.activityIndicator(animate: false)
        if let index = citiesForScreen.firstIndex(of: newCity) {
            view.addRow(at: index)
        }
    }
    
    func notFindLocation(for cityName: String, error: Error) {
        view.activityIndicator(animate: false)
        view.showAlertNotLocationFor(cityName: cityName, error: error)
    }
    
    func didAlreadyExists(city: City) {
        view.activityIndicator(animate: false)
        view.showAlertAlreadyExists(cityName: city.name)
    }
}

//MARK: - DetailPresenterDelegate

extension MainPresenter: DetailPresenterDelegate {
    func changeCoordinate(for city: City) {
        interactor.changeCoordinate(for: city)
        getWeather(for: city)
    }
}
