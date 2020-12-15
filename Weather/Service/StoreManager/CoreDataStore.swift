//
//  StoreCity.swift
//  Weather
//
//  Created by Alex on 04.12.2020.
//

import Foundation
import CoreData

class CoreDataStore {
    
    // MARK: - Core Data stack
    
    private lazy var context = persistentContainer.viewContext

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataCity")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Metods

    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func deleteAllCities() {
        let fetchRequest: NSFetchRequest = CityEntity.fetchRequest()
        do {
            let cityEntities = try context.fetch(fetchRequest)
            print("load \(cityEntities.count) city from store for delete all")
            cityEntities.forEach { context.delete($0) }
            saveContext()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    private func add(cities: [City]) {
        cities.forEach {
            let coordinateEntity = CoordinateEntity(context: context)
            coordinateEntity.latitude = $0.coordinate.latitude
            coordinateEntity.longitude = $0.coordinate.longitude
            let cityEntity = CityEntity(context: context)
            cityEntity.name = $0.name
            cityEntity.sortedNumber = $0.sortedNumber
            cityEntity.coordinate = coordinateEntity
        }
        saveContext()
    }
}

//MARK: - StoreManagerProtocol

extension CoreDataStore: StoreManagerProtocol {
    
    func loadCitiesFromStore(complete: @escaping ([City]) -> Void) {
        let fetchRequest: NSFetchRequest = CityEntity.fetchRequest()
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(CityEntity.sortedNumber), ascending: true)]
        do {
            let cityEntities = try context.fetch(fetchRequest)
            print("load \(cityEntities.count) city from store")
            let cities = cityEntities.map { return City(cityEntity: $0) }
            complete(cities)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func saveToStore(_ cities: [City]) {
        deleteAllCities()
        add(cities: cities)
    }
}
