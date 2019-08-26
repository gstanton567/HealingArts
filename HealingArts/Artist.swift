//
//  Artist.swift
//  HealingArts
//
//  Created by Keegan Brown on 7/2/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import Foundation
import UIKit

class Artist {
    
    var name : String?
    var textDesc : String?
    var images : [UIImage]
    var website : String
    
    init(name : String, textDesc : String, images : [UIImage], website : String) {
        self.name = name
        self.textDesc = textDesc
        self.images = images
        self.website = website
    }
    
}
