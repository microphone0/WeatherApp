//
//  Forecast.swift
//  Weather
//
//  Created by Adam Saxton on 8/28/24.
//

import Foundation
import UIKit

// Define Structs for Location data
struct Coordinates: Codable {
    let lon: Float
    let lat: Float
}

struct LocationInformation: Codable {
    let type: Int?
    let id: Int?
    let message: String?
    let country: String?
    let sunrise: Int?
    let sunset: Int?
}

// Struct for the Forecast for one location
struct Forecast: Codable {
    let coord: Coordinates
    let weather: [Weather]
    let base: String?
    let main: OtherWeatherConditions
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let rain: Rain?
    let snow: Snow?
    let dt: Int?
    let sys: LocationInformation?
    let timezone: Int?
    let id: Int
    let name: String
    let cod: Int?
    var image: Data?
    var cityStateOrCurrentLocation: String?
}
