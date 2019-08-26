//
//  Event.swift
//  HealingArts
//
//  Created by Grayson Stanton on 7/1/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase
import FirebaseFirestore
import FirebaseStorage

class Event {
    
    var title: String?
    var date: String?
    var summary: String?
    //    var imageURLs: [String]?
    var image: UIImage
    var location: String?
    var test = false
    
    init(title: String, date: String?, summary: String, image: UIImage, location: String?) {
        self.title = title
        self.date = date
        self.summary = summary
        self.image = image
        self.location = location
//        getImageURL(summary: self.summary!) { success, image  in
//            if success {
//                self.image = image
//                self.test = true
//                print("reload")
//            }
//        }
    }
    
    
    func getImageURL(summary: String, completion: @escaping (Bool, UIImage) -> Void) {
        var splitters = [""]
        if summary.contains("https:") {
            splitters = summary.components(separatedBy: "&&")
            let imgArray = splitters.first!
            let url = URL(fileURLWithPath: "\(splitters.first!)")
            NetworkManager.getImagesWith(urlStrings: [imgArray]) { (image) in
                print(self.image)
                self.image = image.first!
                print(self.image)
                //print("Oooga 2ga")
                completion(true, image.first!)
                
            }
                self.summary = splitters[1]
            }
            //put in view controller
        }
    }


