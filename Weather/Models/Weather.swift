//
//  Weather.swift
//  Weather
//
//  Created by Adam Saxton on 8/28/24.
//

import Foundation

// Define a specific Weather struct that has the basic information about the weather of a location
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
