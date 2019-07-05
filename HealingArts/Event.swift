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
    
    init(title: String, date: String?, summary: String, image: UIImage, location: String?) {
        self.title = title
        self.date = date
        self.summary = summary
        self.image = image
        self.location = location
    }
}


