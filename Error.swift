//
//  Error.swift
//  Weather
//
//  Created by Adam Saxton on 8/30/24.
//

// TODO: Look into handling Errors a little better instead of letting the app run

import Foundation

enum ErrorWithData: Error {
    case retrievingData
    case savingData
    case retrievingImageFromURL
    case makingImageURL
    case missingDataUrl
}
