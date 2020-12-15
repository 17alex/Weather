//
//  StoreManagerProtocol.swift
//  Weather
//
//  Created by Alex on 04.12.2020.
//

import Foundation

protocol StoreManagerProtocol {
    func loadCitiesFromStore(complete: @escaping ([City]) -> Void)
    func saveToStore(_ cities: [City])
}
