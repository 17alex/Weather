//
//  DetailRouter.swift
//  Weather
//
//  Created by Alex on 24.11.2020.
//

import UIKit
import CoreLocation

protocol DetailRouterProtocol {
    func showMap(for city: City, changeCoordinateCallback:  ((CLLocationCoordinate2D) -> Void)?)
    func dismissDetail()
}

class DetailRouter {
    
    unowned var view: UIViewController!
    private let assembly: Assembly
    
    //MARK: - Init
    
    init(assembly: Assembly) {
        self.assembly = assembly
    }
}

//MARK: - DetailRouterProtocol

extension DetailRouter: DetailRouterProtocol {
    func showMap(for city: City, changeCoordinateCallback:  ((CLLocationCoordinate2D) -> Void)?) {
        let mapVC = assembly.createMap(for: city.name, coordinate: city.coordinate, changeCoordinateCallback: changeCoordinateCallback)
        view.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    func dismissDetail() {
        view.navigationController?.popViewController(animated: true)
    }
}
