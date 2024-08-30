//
//  DataFetcher.swift
//  Weather
//
//  Created by Adam Saxton on 8/29/24.
//

// TODO: Maybe separate the url contructor variable into a function or class, so it can inlcude things like other contries, languages, etc.

import Foundation

class DataFetcher {
    
    private let apiKey = "3cd0795d231ae72ad5ee547f299a5447"
    
    func getWeatherData(location: String) async throws -> Forecast {
        let locationURLString = "https://api.openweathermap.org/data/2.5/weather?\(location)&units=imperial&lang=en&appid=\(apiKey)"
        
        guard let url = URL(string: locationURLString) else { throw ErrorWithData.missingDataUrl }
        
        let request = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Make sure that response came back corerectly with the right status code
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw ErrorWithData.retrievingData }
        
        var fetchedData = try JSONDecoder().decode(Forecast.self, from: data)
        
        // Get the image data from ImageFetcher
        fetchedData.image = try await ImageFetcher.shared.imageFetcher(imageName: fetchedData.weather[0].iconImageNumber)
                
        return fetchedData
    }
    
    func saveLastLocation(forecast: Forecast) throws {
        let encoder = JSONEncoder()
        
        let data = try encoder.encode(forecast)
        
        UserDefaults.standard.set(data, forKey: "weatherAppLastLocation")
    }
}
