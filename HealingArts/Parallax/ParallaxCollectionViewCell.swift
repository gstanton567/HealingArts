//
//  ParallaxCollectionViewCell.swift
//  ParallaxSwift
//
//  Created by Grayson Stanton on 6/10/19.
//  Copyright © 2019 Grayson Stanton. All rights reserved.
//

import UIKit

class ParallaxCollectionViewCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    var maxParallaxOffset: CGFloat = 50.0
    
    var imageViewHeightConstraint: NSLayoutConstraint!
    var imageViewCenterYConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        setupImageView()
        setupConstraints()
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
    
    func setupImageView() {
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
    }
    
    func setupConstraints() {
        imageViewHeightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 1.0, constant: 0.0)
        imageViewCenterYConstraint = NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0)

        let constraints = [
            imageViewHeightConstraint!,
            imageViewCenterYConstraint!,
            NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: 0.0)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        imageViewHeightConstraint.constant = 2 * maxParallaxOffset
    }
    
//    func setMaxParallaxOffset(maxParallaxOffset: CGFloat) {
//        self.maxParallaxOffset = maxParallaxOffset
//        self.setNeedsUpdateConstraints()
//    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let parallaxLayoutAttributes = layoutAttributes as! ParallaxLayoutAttributes
        imageViewCenterYConstraint.constant = parallaxLayoutAttributes.parallaxOffset!.y
    }
    
}
