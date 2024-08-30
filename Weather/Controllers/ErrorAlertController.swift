//
//  ErrorAlertController.swift
//  Weather
//
//  Created by Adam Saxton on 8/30/24.
//

// TODO: Combine both Alert Controller classes into one where all you have to do is enter in messages and have only one Alert Controller class

import Foundation
import UIKit

class ErrorAlertController {
    func showErrorAlertWithMessage(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        
        return alert
    }
}
