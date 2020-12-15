//
//  DetailPresenter.swift
//  Weather
//
//  Created by Alex on 03.11.2020.
//

import Foundation

protocol DetailPresenterDelegate: class {
    func changeCoordinate(for city: City)
}

protocol DetailPresenterProtocol {
    func start()
    func mapButtonPress()
}

class DetailPresenter {
    
    unowned var view: DetailViewProtocol!
    private let router: DetailRouterProtocol
    
    var city: City
    var weatherModel: WeatherModel?
    weak var delegate: DetailPresenterDelegate?
    
    init(router: DetailRouterProtocol, city: City, weatherModel: WeatherModel?) {
        self.router = router
        self.city = city
        self.weatherModel = weatherModel
    }
}

//MARK: - DetailPresenterProtocol

extension DetailPresenter: DetailPresenterProtocol {
    func start() {
        let detailWeatherViewModel = DetailWeatherViewModel(cityName: city.name, weatherModel: weatherModel)
        view.showCity(weatherModel: detailWeatherViewModel)
    }
    
    func mapButtonPress() {
        router.showMap(for: city) { (coordinate) in
            self.city.coordinate = coordinate
            self.delegate?.changeCoordinate(for: self.city)
        }
    }
}
