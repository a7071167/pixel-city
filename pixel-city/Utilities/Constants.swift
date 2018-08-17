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

// func for API
func flickrUrl(forApiKey key: String, withAnnotation annotation: DroppablePin, andNumbersOfPhotos number: Int) -> String {
    return "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(key)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=km&per_page=\(number)&format=json&nojsoncallback=1"
}

func getNameById(withId idOwner: String) -> String {
    return "https://api.flickr.com/services/rest/?method=flickr.people.getInfo&api_key=\(apiKey)&user_id=\(idOwner)&format=json&nojsoncallback=1"
}

// Notification

let LOADED_ONE_BIGSIZE_PIC = "Loaded"
let LOADED_ONE_SMALL_PIC_IN_COLLECTION = "PictureIsLoaded"
let LOADED_USERNAME_REALNAME = "LoadUsernameRealname"


// Identifiers

let DROPPABLE_PIN = "droppablePin"
let COLLECTIONVIEW_REUSE_ID = "photoCell"
let POP_VC = "PopVC"
