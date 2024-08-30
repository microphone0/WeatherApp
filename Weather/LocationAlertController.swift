//
//  LocationAlertController.swift
//  Weather
//
//  Created by Adam Saxton on 8/29/24.
//

import Foundation
import UIKit

class LocationAlertController {
    func showAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Location Access was Denied", message: "Please go to \"Settings -> Privacy & Security -> Location\" to enable location access", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        
        return alert
    }
}
