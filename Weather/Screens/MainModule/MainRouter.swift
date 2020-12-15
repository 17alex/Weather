//
//  MainRouter.swift
//  Weather
//
//  Created by Alex on 10.11.2020.
//

import UIKit
import CoreLocation

protocol MainRouterProtocol {
    func showDetailWeather(for city: City, weatherModel: WeatherModel?, delegate: DetailPresenterDelegate?)
    func showMap(for cityName: String, changeCoordinateCallback: @escaping (CLLocationCoordinate2D) -> Void)
    func dismiss()
}

class MainRouter {
    
    //MARK: Propertis
    
    unowned var view: UIViewController!
    private let assembly: Assembly
    
    //MARK: - Init
    
    init(with assembly: Assembly) {
        self.assembly = assembly
    }
}

//MARK: - MainRouterProtocol

extension MainRouter: MainRouterProtocol {
    
    func showDetailWeather(for city: City, weatherModel: WeatherModel?, delegate: DetailPresenterDelegate?) {
        let detailVC = assembly.createDetail(city: city, weatherModel: weatherModel, delegate: delegate)
        view.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func showMap(for cityName: String, changeCoordinateCallback: @escaping (CLLocationCoordinate2D) -> Void) {
        let mapVC = assembly.createMap(for: cityName, coordinate: nil, changeCoordinateCallback: changeCoordinateCallback)
        view.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    func dismiss() {
        view.navigationController?.popViewController(animated: true)
    }
    
}
