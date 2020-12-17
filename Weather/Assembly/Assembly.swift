//
//  Bilder.swift
//  Weather
//
//  Created by Alex on 02.11.2020.
//

import UIKit
import CoreLocation

class Assembly {
    
    func createMain() -> UIViewController {
        let networkManager = NetworkManager()
        let locationManager = LocationManager()
        let storeManager = RealmStore()
//        let storeManager = CoreDataStore()
//        let storeManager = UserDefaultsStore()
        let interactor = MainInteractor()
        let presenter = MainPresenter(interactor: interactor)
        let view = MainViewController(presenter: presenter)
        interactor.networkManager = networkManager
        interactor.locationManager = locationManager
        interactor.storeManager = storeManager
        interactor.presenter = presenter
        let router = MainRouter(with: self)
        router.view = view
        presenter.router = router
        presenter.view = view
        return view
    }
    
    func createDetail(city: City, weatherModel: WeatherModel?,delegate: DetailPresenterDelegate?) -> UIViewController {
        let router = DetailRouter(assembly: self)
        let presenter = DetailPresenter(router: router, city: city, weatherModel: weatherModel)
        let view = DetailViewController(presenter: presenter)
        presenter.view = view
        presenter.delegate = delegate
        router.view = view
        return view
    }
    
    func createMap(for cityName: String, coordinate: CLLocationCoordinate2D?, changeCoordinateCallback:  ((CLLocationCoordinate2D) -> Void)?) -> UIViewController {
        let router = MapRouter(assembly: self)
        let presenter = MapPresenter(router: router, cityName: cityName, coordinate: coordinate, changeCoordinateCallback: changeCoordinateCallback)
        let view = MapViewController(presenter: presenter)
        presenter.view = view
        router.view = view
        return view
    }
}
