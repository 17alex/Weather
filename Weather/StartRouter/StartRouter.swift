//
//  StartRouter.swift
//  Weather
//
//  Created by Alex on 01.12.2020.
//

import UIKit

class StartRouter {
    
    let assembly: Assembly
    
    init(assembly: Assembly) {
        self.assembly = assembly
    }
    
    func getStartViewController() -> UIViewController {
        assembly.createMain()
    }
}
