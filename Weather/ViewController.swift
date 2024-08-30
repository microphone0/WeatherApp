//
//  ViewController.swift
//  Weather
//
//  Created by Adam Saxton on 8/28/24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var tempAndStatusLabel: UILabel!
    @IBOutlet var feelsLikeLabel: UILabel!
    @IBOutlet var weatherDescLabel: UILabel!
    @IBOutlet var imageLabel: UIImageView!
    
    var locationManager: CLLocationManager?
    var forecast: Forecast?
    
    required init?(coder: NSCoder) {
        forecast = nil
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        
        searchBar.delegate = self
        
        if let data = UserDefaults.standard.data(forKey: "weatherAppLastLocation") {
            do {
                let decoder = JSONDecoder()
                let weatherForecast = try decoder.decode(Forecast.self, from: data)
                forecast = weatherForecast
            } catch {
                fatalError("Error Decoding data")
            }
        }
        
        updateView()
    }
    
    func updateView() {
        guard let forecast = forecast else { return }
        locationLabel.text = forecast.cityStateOrCurrentLocation
        weatherDescLabel.text = forecast.weather[0].description
        if let temp = forecast.main.actualTemp {
            tempAndStatusLabel.text = "\(temp)° \(forecast.weather[0].main)"
        }
        if let feelsLike = forecast.main.feelsLike {
            feelsLikeLabel.text = "\(feelsLike)"
        }
        if let imageData = forecast.image {
            imageLabel.image = UIImage(data: imageData)
        }
    }

    @IBAction func locationButton(_ sender: Any) {
        if locationManager?.authorizationStatus == .denied {
            let alert = LocationAlertController().showAlert()
            present(alert, animated: true)
        } else if locationManager?.authorizationStatus == .authorizedWhenInUse {
            locationManagerDidChangeAuthorization(locationManager!)
        }
    }
    
    // Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            guard let location = manager.location?.coordinate else { fatalError("Failed to get location from Location Manager") }
            Task {
                do {
                    
                    forecast = try await DataFetcher().getWeatherDataWithCoords(lat: "\(location.latitude)", lon: "\(location.longitude)")
                    searchBar.text = "Current Location"
                    forecast?.cityStateOrCurrentLocation = "Current Location"
                    guard let forecast = self.forecast else { fatalError("Error getting forecast") }
                    try DataFetcher().saveLastLocation(forecast: forecast)
                    updateView()
                } catch {
                    fatalError("Error getting data")
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Task {
            do {
                forecast = try await DataFetcher().getWeatherDataWithCityState(location: searchBar.text ?? "")
                forecast?.cityStateOrCurrentLocation = searchBar.text
                guard let forecast = self.forecast else { fatalError("Error getting forecast") }
                try DataFetcher().saveLastLocation(forecast: forecast)
                updateView()
            } catch {
                fatalError("Error getting data")
            }
        }
    }
}

