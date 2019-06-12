//
//  ParallaxLayoutAttributes.swift
//  ParallaxSwift
//
//  Created by Grayson Stanton on 6/10/19.
//  Copyright © 2019 Grayson Stanton. All rights reserved.
//

import UIKit

class ParallaxLayoutAttributes: UICollectionViewLayoutAttributes {
    var parallaxOffset: CGPoint?
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! ParallaxLayoutAttributes
        copy.parallaxOffset = self.parallaxOffset
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard object is ParallaxLayoutAttributes, let otherObject = object as? ParallaxLayoutAttributes else { return false }
        guard __CGPointEqualToPoint(parallaxOffset!, otherObject.parallaxOffset!) else { return false }

        return super.isEqual(otherObject)
    }
    
}
