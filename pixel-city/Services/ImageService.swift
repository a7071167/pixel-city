//
//  ImageService.swift
//  pixel-city
//
//  Created by user on 16.08.2018.
//  Copyright © 2018 user. All rights reserved.
//
import UIKit
import Foundation
import Alamofire
import AlamofireImage

class ImageService {
    
    private init() {}
    
    static let instance = ImageService()
    
    
    var imageUrlArray = [String]()
    var ownerNames = [String]()
    var imageArray = [UIImage]()
    var imageUrlArray640x480 = [String]()
    var imageArray640x480 = [UIImage]()
    var realName = String()

    var bigImage = [UIImage]()
    
    
    func retrieveUrls(forAnnotation annotaion: DroppablePin, completion: @escaping (_ status: Bool) -> ()) {
        
        Alamofire.request(flickrUrl(forApiKey: apiKey, withAnnotation: annotaion, andNumbersOfPhotos: 30)).responseJSON { (response) in
            print(response)
            guard let json = response.result.value as? Dictionary<String, AnyObject> else { return }
            let photosDict = json["photos"] as! Dictionary<String, AnyObject>
            let photosDictArray = photosDict["photo"] as! [Dictionary<String, AnyObject>]
            for photo in photosDictArray {
                let postUrl = "https://farm\(photo["farm"]!).staticflickr.com/\(photo["server"]!)/\(photo["id"]!)_\(photo["secret"]!)_q_d.jpg"
                let postUrl640x480 = "https://farm\(photo["farm"]!).staticflickr.com/\(photo["server"]!)/\(photo["id"]!)_\(photo["secret"]!)_z_d.jpg"
                let owner = photo["owner"] as! String
                self.ownerNames.append(owner)
                self.imageUrlArray.append(postUrl)
                self.imageUrlArray640x480.append(postUrl640x480)
            }
            completion(true)
        }
    }
    
    func retrieveImages(completion: @escaping (_ status: Bool) ->()) {
        
        for url in imageUrlArray {
            Alamofire.request(url).responseImage { (response) in
                guard let image = response.result.value else { return }
                self.imageArray.append(image)
                NotificationCenter.default.post(name: NSNotification.Name(LOADED_ONE_SMALL_PIC_IN_COLLECTION), object: nil)
                if self.imageArray.count == self.imageUrlArray.count || self.imageArray.count == self.ownerNames.count {
                    completion(true)
                }
                
            }
        }
    }
    
    func retrieveOneImage(forIndex indexPath: Int ,completion: @escaping (_ status: Bool) -> ()) {
        ImageService.instance.bigImage = []
        let url = imageUrlArray640x480[indexPath]
        Alamofire.request(url).responseImage { (response) in
            guard let image = response.result.value else { return }
            ImageService.instance.bigImage.append(image)
            if ImageService.instance.bigImage.count == 1 {
                completion(true)
            }
        }
    }
    
    func getUserRealName(fromOwnerIndex indexPath: Int, completion: @escaping (_ status: Bool) -> ()) {
        let owner = ownerNames[indexPath]
        var content = "____"
        Alamofire.request(getNameById(withId: owner)).responseJSON { (response) in
            print(response)
            guard let json = response.result.value as? Dictionary<String, AnyObject> else { return }
            let personDict = json["person"] as! Dictionary<String, AnyObject>
            if let realName = personDict["realname"] as? Dictionary<String, String> {
                content = (realName["_content"])!
            } else {
                let userName = personDict["username"] as! Dictionary<String, String>
                content = (userName["_content"])!
            }
            self.realName = content
            print(self.realName)
            completion(true)
        }
    }
    
    func clearUrls() {
        imageUrlArray = []
        imageUrlArray640x480 = []
        imageArray = []
        ownerNames = []
    }
}
