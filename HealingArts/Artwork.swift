//
//  Artwork.swift
//  HealingArts
//
//  Created by Carly Cameron on 6/10/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase
import FirebaseFirestore
import FirebaseStorage

class Artwork {
    
    var title: String?
    var artist: String?
    var dimensions: String?
    var date: String?
    var floor: Int?
    var textDescription: String?
    var medium: String?
    var location: GeoPoint?
//    var imageURLs: [String]?
    var images: [UIImage]?
    var donor: String?
    
    init(title: String, artist: String, dimensions: String?, date: String?, floor: Int?, textDescription: String?, medium: String?, location: GeoPoint?, images: [UIImage]?, donor: String?) {
        self.title = title
        self.artist = artist
        self.dimensions = dimensions
        self.date = date
        self.floor = floor
        self.textDescription = textDescription
        self.medium = medium
        self.location = location
        self.images = images!
        self.donor = donor
    }
}

