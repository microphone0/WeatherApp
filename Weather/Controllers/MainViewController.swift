//
//  ViewController.swift
//  Weather
//
//  Created by Adam Saxton on 8/28/24.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var tempAndStatusLabel: UILabel!
    @IBOutlet var feelsLikeLabel: UILabel!
    @IBOutlet var weatherDescLabel: UILabel!
    @IBOutlet var imageLabel: UIImageView!
    
    // Needed for getting the user's location
    var locationManager: CLLocationManager?
    
    var forecast: Forecast?
    
    required init?(coder: NSCoder) {
        forecast = nil
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize Location Manager and it's delegate and SearchBar delegate when we have fully loaded the view
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        
        searchBar.delegate = self
        
        // Pull up the last place searched (if any) on start up and displays the latest forecast otherwise just display nothing
        if let data = UserDefaults.standard.data(forKey: "weatherAppLastLocation") {
            do {
                let decoder = JSONDecoder()
                let weatherForecast = try decoder.decode(Forecast.self, from: data)
                
                // Sets searchBar text to help with edge case where sometimes city and state wouldn't display even if there was one
                searchBar.text = weatherForecast.cityStateOrCurrentLocation
                
                if weatherForecast.cityStateOrCurrentLocation == "Current Location" {
                    locationManagerDidChangeAuthorization(locationManager!)
                } else {
                    guard let weatherForecastCityState = weatherForecast.cityStateOrCurrentLocation else { return }
                    fetchWeatherData(location: "q=\(weatherForecastCityState),US")
                }
            } catch {
                fatalError("Error Decoding data")
            }
        } else {
            updateView()
        }
    }
    
    func updateView() {
        // Try to unwrap optional values if it's nil then just leave label blank
        guard let forecast = forecast else { return }
        locationLabel.text = forecast.cityStateOrCurrentLocation
        weatherDescLabel.text = forecast.weather[0].secondaryDesc
        if let temp = forecast.main.currentTemp {
            tempAndStatusLabel.text = "\(temp)° \(forecast.weather[0].mainDesc)"
        }
        if let feelsLike = forecast.main.feelsLike {
            feelsLikeLabel.text = "\(feelsLike)°"
        }
        if let imageData = forecast.image {
            imageLabel.image = UIImage(data: imageData)
        }
    }

    @IBAction func locationButton(_ sender: Any) {
        if locationManager?.authorizationStatus == .denied {
            // Show custom alert asking user to enable location since the os doesn't ask them if they already denied once
            let alert = LocationAlertController().showAlert()
            present(alert, animated: true)
        } else if locationManager?.authorizationStatus == .authorizedWhenInUse {
            locationManagerDidChangeAuthorization(locationManager!)
        }
    }
    
    func fetchWeatherData(location: String) {
        Task {
            do {
                forecast = try await DataFetcher().getWeatherData(location: location)
                
                // if else handles cases where the location label wasn't being set properly
                if forecast?.name != "" && searchBar.text != "" {
                    self.forecast?.cityStateOrCurrentLocation = searchBar.text
                    searchBar.text = ""
                } else if forecast?.name != "" {
                    let name = forecast?.name
                    self.forecast?.cityStateOrCurrentLocation = name
                } else {
                    self.forecast?.cityStateOrCurrentLocation = "Current Location"
                }
                guard let forecast = self.forecast else { fatalError("Error getting forecast") }
                // Saves data for when user closes the app so it can gives last location's info on app launch
                try DataFetcher().saveLastLocation(forecast: forecast)
            } catch {
                fatalError("Error getting data")
            }
            updateView()
        }
    }
    
/// Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Always run when app starts as well and if user allowed location use then the app will automatically display current location forecast
        if manager.authorizationStatus == .authorizedWhenInUse {
            guard let location = manager.location?.coordinate else { fatalError("Failed to get location from Location Manager") }
            // Get locations coords and format string to make url string to work
            let locationCoords = "lat=\(location.latitude)&lon=\(location.longitude)"
            fetchWeatherData(location: locationCoords)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Fetches text from search bar when user presses enter and formats string to work well with url string
        fetchWeatherData(location: "q=\(searchBar.text ?? ""),US")
    }
}

