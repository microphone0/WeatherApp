//
//  WeatherConditions.swift
//  Weather
//
//  Created by Adam Saxton on 8/28/24.
//

import Foundation

// Define structs for weather conditions that might be in a Forecast
// Separeted these structs from the rest for readabily sake
struct Wind: Codable {
    let speed: Float?
    let deg: Int?
    let gust: Float?
}

struct Clouds: Codable {
    let clouds: Int?
}

struct Rain: Codable {
    let oneHour: Float?
    let threeHours: Float?
    
    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHours = "3h"
    }
}

struct Snow: Codable {
    let oneHour: Float?
    let threeHours: Float?
    
    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHours = "3h"
    }
}

struct OtherWeatherConditions: Codable {
    let actualTemp: Float?
    let feelsLike: Float?
    let tempMin: Float?
    let tempMax: Float?
    let pressure: Int?
    let humidity: Int?
    let atmPressureSea: Int?
    let atmPressureGround: Int?
    
    enum CodingKeys: String, CodingKey {
        case actualTemp = "temp"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case atmPressureSea = "sea_level"
        case atmPressureGround = "grnd_level"
        
        case humidity, pressure
    }
}
