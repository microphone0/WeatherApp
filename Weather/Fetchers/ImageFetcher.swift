//
//  ImageFetcher.swift
//  Weather
//
//  Created by Adam Saxton on 8/29/24.
//

import Foundation
import UIKit

class ImageFetcher {
    static let shared = ImageFetcher()
    // Creates temporary cache for images so the app doesn't have to keep getting images from online
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    private init() { }
    
    func imageFetcher(imageName: String) async throws -> Data {
        
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(imageName)@2x.png") else { throw ErrorWithData.makingImageURL }
        
        // See if image exists is cache and get the data from it if it does
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? Data {
            return imageFromCache
        }
        
        // If image doesn't exist in cache then go ahead and fetch the image
        let request = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw ErrorWithData.retrievingImageFromURL }
        
        imageCache.setObject(data as AnyObject, forKey: url as AnyObject)
        
        return data
    }
}
