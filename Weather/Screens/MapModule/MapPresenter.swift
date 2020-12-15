//
//  MapPresenter.swift
//  Weather
//
//  Created by Alex on 24.11.2020.
//

import Foundation
import CoreLocation

protocol MapPresenterProtocol {
    func start()
    func saveCoordinate(_ coordinate: CLLocationCoordinate2D)
}

class MapPresenter {
    
    //MARK: Propertis
    
    unowned var view: MapViewProtocol!
    private let router: MapRouterProtocol
    
    private var cityName: String
    private var coordinate: CLLocationCoordinate2D?
    private var changeCoordinateCallback: ((CLLocationCoordinate2D) -> Void)?
    
    //MARK: Init
    
    init(router: MapRouterProtocol, cityName: String, coordinate: CLLocationCoordinate2D?, changeCoordinateCallback: ((CLLocationCoordinate2D) -> Void)?) {
        self.router = router
        self.cityName = cityName
        self.coordinate = coordinate
        self.changeCoordinateCallback = changeCoordinateCallback
    }
}

//MARK: - MapPresenterProtocol

extension MapPresenter: MapPresenterProtocol {
    func start() {
        view.showMap(for: cityName, coordinate: coordinate)
    }
    
    func saveCoordinate(_ coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        changeCoordinateCallback?(coordinate)
        router.dissmisMapToRoot()
    }
}
