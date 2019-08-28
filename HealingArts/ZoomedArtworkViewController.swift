//
//  ZoomedArtworkViewController.swift
//  HealingArts
//
//  Created by Gwyneth Semanisin on 8/27/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit

class ZoomedArtworkViewController: UIViewController, UIScrollViewDelegate {
    
    var artwork = UIImage()
    var imageView: UIImageView!
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: artwork)
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.black
        scrollView.contentSize = imageView.bounds.size
        scrollView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
        //5. Intial view is of the left corner so adjust it to be closer to center
        let imageViewSize = imageView.bounds.size
        scrollView.contentOffset = CGPoint(x: imageViewSize.width/2 - 200, y: imageViewSize.height/2 - 400)
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        scrollView.delegate = self
        
        setZoomScale()
    }
    
    //function to make image aspect fit
    func setZoomScale() {
        //
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.maximumZoomScale = 5.0
        scrollView.zoomScale = 1.0
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    override func viewWillLayoutSubviews() {
        setZoomScale()
    }
    
}
