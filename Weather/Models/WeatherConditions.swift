//
//  WeatherConditions.swift
//  Weather
//
//  Created by Adam Saxton on 8/28/24.
//

import Foundation

// Define structs for weather conditions that might be in a Forecast
// Separeted these structs from the rest for readabily sake
struct Weather: Codable {
    let id: Int
    let mainDesc: String
    let secondaryDesc: String
    let iconImageNumber: String
    
    enum CodingKeys: String, CodingKey {
        case mainDesc = "main"
        case secondaryDesc = "description"
        case iconImageNumber = "icon"
        
        case id
    }
}

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
    
    // Variables can't have a number in them, so have to create custom keys
    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHours = "3h"
    }
}

struct Snow: Codable {
    let oneHour: Float?
    let threeHours: Float?
    
    // Variables can't have a number in them, so have to create custom keys
    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHours = "3h"
    }
}

struct OtherWeatherConditions: Codable {
    let currentTemp: Float?
    let feelsLike: Float?
    let tempMin: Float?
    let tempMax: Float?
    let pressure: Int?
    let humidity: Int?
    let atmPSea: Int?
    let atmPGround: Int?
    
    // Create custom keys to have better names
    enum CodingKeys: String, CodingKey {
        case currentTemp = "temp"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        // atm and P are abbreviations for atmospheric pressure and API that's what these values are
        case atmPSea = "sea_level"
        case atmPGround = "grnd_level"
        
        case humidity, pressure
    }
}
