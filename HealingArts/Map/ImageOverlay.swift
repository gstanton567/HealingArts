//
//  ImageOverlay.swift
//  HealingArts
//
//  Created by Keegan Brown on 7/2/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class ImageOverlay : NSObject, MKOverlay {
    
    let image:UIImage
    let boundingMapRect: MKMapRect
    let coordinate:CLLocationCoordinate2D
    
    init(image: UIImage, rect: MKMapRect) {
        self.image = image
        self.boundingMapRect = rect
        self.coordinate = CLLocationCoordinate2D(latitude: 41.2553838, longitude: -95.9795296)
    }
}

class ImageOverlayRenderer : MKOverlayRenderer {
    
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        
        guard let overlay = self.overlay as? ImageOverlay else {
            return
        }
        
        let rect = self.rect(for: overlay.boundingMapRect)
        
        UIGraphicsPushContext(context)
        overlay.image.draw(in: rect)
        UIGraphicsPopContext()
    }
}
