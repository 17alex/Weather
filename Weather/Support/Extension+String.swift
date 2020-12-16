//
//  Extension+String.swift
//  Weather
//
//  Created by Alex on 26.10.2020.
//

import Foundation

extension String {
    func returnCapitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.returnCapitalizingFirstLetter()
    }
    
    var localizeWindDir: String {
        switch self {
        case "nw":  return NSLocalizedString("nw", comment: "")
        case "n":   return NSLocalizedString("n", comment: "")
        case "ne":  return NSLocalizedString("ne", comment: "")
        case "e":   return NSLocalizedString("e", comment: "")
        case "se":  return NSLocalizedString("se", comment: "")
        case "s":   return NSLocalizedString("s", comment: "")
        case "sw":  return NSLocalizedString("sw", comment: "")
        case "w":   return NSLocalizedString("w", comment: "")
        case "с":   return NSLocalizedString("с", comment: "")
        default:    return NSLocalizedString("error", comment: "")
        }
    }
    
    var localizeCondition: String {
        switch self {
        case "clear":                   return NSLocalizedString("clear", comment: "")
        case "partly-cloudy":           return NSLocalizedString("partly-cloudy", comment: "")
        case "cloudy":                  return NSLocalizedString("cloudy", comment: "")
        case "overcast":                return NSLocalizedString("overcast", comment: "")
        case "drizzle":                 return NSLocalizedString("drizzle", comment: "")
        case "light-rain":              return NSLocalizedString("light-rain", comment: "")
        case "rain":                    return NSLocalizedString("rain", comment: "")
        case "moderate-rain":           return NSLocalizedString("moderate-rain", comment: "")
        case "heavy-rain":              return NSLocalizedString("heavy-rain", comment: "")
        case "continuous-heavy-rain":   return NSLocalizedString("continuous-heavy-rain", comment: "")
        case "showers":                 return NSLocalizedString("showers", comment: "")
        case "wet-snow":                return NSLocalizedString("wet-snow", comment: "")
        case "light-snow":              return NSLocalizedString("light-snow", comment: "")
        case "snow":                    return NSLocalizedString("snow", comment: "")
        case "snow-showers":            return NSLocalizedString("snow-showers", comment: "")
        case "hail":                    return NSLocalizedString("hail", comment: "")
        case "thunderstorm":            return NSLocalizedString("thunderstorm", comment: "")
        case "thunderstorm-with-rain":  return NSLocalizedString("thunderstorm-with-rain", comment: "")
        case "thunderstorm-with-hail":  return NSLocalizedString("thunderstorm-with-hail", comment: "")
        default:                        return NSLocalizedString("error", comment: "")
        }
    }
    
    var localizePartName: String {
        switch self {
        case "night":   return NSLocalizedString("night", comment: "")
        case "morning": return NSLocalizedString("morning", comment: "")
        case "day":     return NSLocalizedString("day", comment: "")
        case "evening": return NSLocalizedString("evening", comment: "")
        default:        return NSLocalizedString("error", comment: "")
        }
    }
}

extension String: Error {}
