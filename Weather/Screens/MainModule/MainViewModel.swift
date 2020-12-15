//
//  MainModel.swift
//  Weather
//
//  Created by Alex on 03.11.2020.
//

import Foundation

struct MainViewModel {
    var cityName: String
    var weather: MainWeatherViewModel?
    var loadError: Error?
    
    init(cityName: String, cityWeather: WeatherModel?) {
        self.cityName = cityName
        self.weather = MainWeatherViewModel(serverWeather: cityWeather?.serverWeather)
        self.loadError = cityWeather?.loadError
    }
}

struct MainWeatherViewModel {
    var fact: MainFactViewModel?
    
    init(fact: MainFactViewModel?) {
        self.fact = fact
    }
    
    init(serverWeather: ServerWeather?) {
        if let serverWeather = serverWeather {
            self.fact = MainFactViewModel(serverWeather: serverWeather)
        }
    }
}

struct MainFactViewModel {
    let temp: String
    let icon: String
    let condition: String
    
    init(temp: String, icon: String, condition: String) {
        self.temp = temp
        self.icon = icon
        self.condition = condition
    }
    
    init(serverWeather: ServerWeather) {
        let temp = serverWeather.fact.temp
        let tempString = (temp > 0 ? "+" : "") + String(temp) + "℃"
        self.temp = tempString
        self.icon = serverWeather.fact.icon
        self.condition = serverWeather.fact.condition.localizeCondition
    }
}

