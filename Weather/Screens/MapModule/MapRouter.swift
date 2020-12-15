//
//  MapRouter.swift
//  Weather
//
//  Created by Alex on 24.11.2020.
//

import UIKit

protocol MapRouterProtocol {
    func dissmisMapToRoot()
}

class MapRouter {
    
    unowned var view: UIViewController!
    private let assembly: Assembly
    
    //MARK: - Init
    
    init(assembly: Assembly) {
        self.assembly = assembly
    }
}

//MARK: - MapRouterProtocol

extension MapRouter: MapRouterProtocol {
    func dissmisMapToRoot() {
        view.navigationController?.popToRootViewController(animated: true)
    }
}
