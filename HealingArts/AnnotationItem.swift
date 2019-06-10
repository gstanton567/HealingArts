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

class AnnotationItem {
    
    var title : String!
    var desc : String!
    var coordinate = CLLocationCoordinate2D()
    var imageName : String!
    
    init(name : String, desc: String, coordinate: CLLocationCoordinate2D, imageName : String) {
        self.title = name
        self.desc = desc
        self.coordinate = coordinate
        self.imageName = imageName
    }
    
}
