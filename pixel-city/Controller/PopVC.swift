//
//  PopVC.swift
//  pixel-city
//
//  Created by user on 15.08.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class PopVC: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var popImageView: UIImageView!
    @IBOutlet weak var postedByNameLbl: UILabel!
    
    var passedImage: UIImage!
    var passedLbl: String?
    
    func initData(forImage image: UIImage) {
        self.passedImage = image
//        self.passedLbl = nameLabel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        popImageView.image = passedImage
        postedByNameLbl.text = passedLbl
        addDoubleTap()
        NotificationCenter.default.addObserver(self, selector: #selector(loaded640x480(_:)), name: NSNotification.Name(LOADED_ONE_BIGSIZE_PIC), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadedUserDataOnPict(_:)), name: NSNotification.Name(LOADED_USERNAME_REALNAME), object: nil)
    }
    
    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(screenWasDoubleTapped(_:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        view.addGestureRecognizer(doubleTap)
    }
    
    @objc func screenWasDoubleTapped(_ recognizer: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func loaded640x480(_ nitof: Notification) {
        popImageView.image = ImageService.instance.bigImage.first
    }

    @objc func loadedUserDataOnPict(_ notif: Notification) {
        postedByNameLbl.text = "Posted by: \(ImageService.instance.realName)"
    }
}
