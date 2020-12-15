//
//  DetailModel.swift
//  Weather
//
//  Created by Alex on 03.11.2020.
//

import Foundation

struct DetailWeatherViewModel {
    let cityName: String
    var fact: DetailFactViewModel?
    
    init(cityName: String, weatherModel: WeatherModel?) {
        self.cityName = cityName
        if let serverWeather = weatherModel?.serverWeather {
            let fact = DetailFactViewModel(serverWeather: serverWeather)
            self.fact = fact
        }
    }
}

struct DetailFactViewModel {
    let temp: String
    let icon: String
    let condition: String
    let windSpeed: String
    let windDir: String
    let pressureMm: String
    let humidity: String
    let sunrise: String
    let sunset: String
    let parts: [DetailPart]
    
    init(serverWeather: ServerWeather) {
        let fact = serverWeather.fact
        let forecast = serverWeather.forecast
        let temp = fact.temp
        self.temp = (temp > 0 ? "+" : "") + String(temp) + "℃"
        self.icon = fact.icon
        self.condition = fact.condition.localizeCondition
        self.windSpeed = String(fact.windSpeed) + " " + NSLocalizedString("m/s", comment: "")
        self.windDir = fact.windDir.localizeWindDir
        self.pressureMm = String(fact.pressureMm) + " " + NSLocalizedString("mmHg", comment: "")
        self.humidity = String(fact.humidity) + " %"
        self.sunrise = forecast.sunrise
        self.sunset = forecast.sunset
        self.parts = forecast.parts.map { DetailPart(serverPart: $0) }
    }
}

struct DetailPart {
    let partName: String
    let tempMinMax: String
    let condition: String
    let windSpeedDir: String
    
    init(serverPart: Part) {
        self.partName = serverPart.partName.localizePartName
        self.tempMinMax = String(serverPart.tempMin) + "..." + String(serverPart.tempMax) + "℃"
        self.condition = serverPart.condition.localizeCondition
        self.windSpeedDir = serverPart.windDir.localizeWindDir + " " + String(serverPart.windSpeed) + NSLocalizedString("m/s", comment: "")
    }
}
