//
//  Forecast.swift
//  Weather
//
//  Created by Adam Saxton on 8/28/24.
//

// TODO: Maybe look into changing some names to be more clearer
// TODO: Look into possibly removing some of the properties that we will never use if we can still decode the JSON well enough

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
// API examples didn't specify what was optional or not, and the examples wasn't consistent, so made assumptions about what is optional and not
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
    // These properties help load data when starting the app from launch
    // save image as Data because Codable doesn't like when a property is UIImage
    var image: Data?
    // Also added this one to hold whether to display Current Location if no city was found by coords or to display city name with state since API doesn't give state with the name property
    var cityStateOrCurrentLocation: String?
}
