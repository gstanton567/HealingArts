//
//  AnnotationItem.swift
//  HealingArts
//
//  Created by Keegan Brown on 6/10/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class ArtworkItem {
    
    var title : String!
    var artist : String!
    var coordinate = CLLocationCoordinate2D()
    var imageName : String!
    var distanceToUser : Double!
    
    init(name : String, artist: String, coordinate: CLLocationCoordinate2D, imageName : String, distanceToUser : Double) {
        self.title = name
        self.artist = artist
        self.coordinate = coordinate
        self.imageName = imageName
        self.distanceToUser = distanceToUser
    }
    
}
