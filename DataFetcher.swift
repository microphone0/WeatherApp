//
//  DataFetcher.swift
//  Weather
//
//  Created by Adam Saxton on 8/29/24.
//

import Foundation

class DataFetcher {
    
    private let apiKey = "3cd0795d231ae72ad5ee547f299a5447"
    
    func getWeatherDataWithCoords(lat: String, lon: String) async throws -> Forecast {
        return try await getWeatherData(location: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=imperial&lang=en&appid=\(apiKey)")
    }
    
    func getWeatherDataWithCityState(location: String) async throws -> Forecast {
        return try await getWeatherData(location: "https://api.openweathermap.org/data/2.5/weather?q=\(location),US&units=imperial&lang=en&appid=\(apiKey)")
    }
    
    func getWeatherData(location: String) async throws -> Forecast {
        guard let url = URL(string: location) else { fatalError("Missing URL") }
        
        let request = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching data") }
        
        var fetchedData = try JSONDecoder().decode(Forecast.self, from: data)
        
        fetchedData.image = try await imageFetcher(imageName: fetchedData.weather[0].icon)
        
        try saveLastLocation(forecast: fetchedData)
        
        return fetchedData
    }
    
    func imageFetcher(imageName: String) async throws -> Data {
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(imageName)@2x.png") else { fatalError("Missing Image Name") }
        
        let request = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching image") }
        
        return data
    }
    
    func saveLastLocation(forecast: Forecast) throws {
        let encoder = JSONEncoder()
        
        let data = try encoder.encode(forecast)
        
        UserDefaults.standard.set(data, forKey: "weatherAppLastLocation")
    }
}
