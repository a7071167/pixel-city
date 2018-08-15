//
//  Constants.swift
//  pixel-city
//
//  Created by user on 15.08.2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

// APIKey

let apiKey = "21519db12164547fbe9fa67f8df11202"

func flickrUrl(forApiKey key: String, withAnnotation annotation: DroppablePin, andNumbersOfPhotos number: Int) -> String {
    return "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=km&per_page=\(number)&format=json&nojsoncallback=1"
}

