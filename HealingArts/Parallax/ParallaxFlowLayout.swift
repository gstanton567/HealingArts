//
//  ParallaxFlowLayout.swift
//  ParallaxSwift
//
//  Created by Grayson Stanton on 6/10/19.
//  Copyright © 2019 Grayson Stanton. All rights reserved.
//


import UIKit

class ParallaxFlowLayout: UICollectionViewFlowLayout {
    let maxParallaxOffset: CGFloat = 50.0
    
    override class var layoutAttributesClass: AnyClass { return ParallaxLayoutAttributes.self }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributesForElements = super.layoutAttributesForElements(in: rect) as! [ParallaxLayoutAttributes]
        for layoutAttributes: ParallaxLayoutAttributes in layoutAttributesForElements {
            if layoutAttributes.representedElementCategory == .cell {
                layoutAttributes.parallaxOffset = parallaxOffsetForLayoutAttributes(layoutAttributes: layoutAttributes)
            }
        }
        return layoutAttributesForElements
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let layoutAttributes: ParallaxLayoutAttributes = super.layoutAttributesForItem(at: indexPath) as! ParallaxLayoutAttributes
        layoutAttributes.parallaxOffset = self.parallaxOffsetForLayoutAttributes(layoutAttributes: layoutAttributes)
        return layoutAttributes
    }

    
    func parallaxOffsetForLayoutAttributes(layoutAttributes: ParallaxLayoutAttributes) -> CGPoint {
        let bounds: CGRect = self.collectionView!.bounds
        let boundsCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        let cellCenter: CGPoint = layoutAttributes.center
        let offsetFromCenter = CGPoint(x: boundsCenter.x - cellCenter.x, y: boundsCenter.y - cellCenter.y)
        let cellSize: CGSize = layoutAttributes.size
        let maxVerticalOffsetWhereCellIsStillVisible: CGFloat = (bounds.size.height / 2) + (cellSize.height / 2)
        let scaleFactor: CGFloat = self.maxParallaxOffset / maxVerticalOffsetWhereCellIsStillVisible
        let parallaxOffset = CGPoint(x: 0.0, y: offsetFromCenter.y * scaleFactor)
        return parallaxOffset
    }
}


