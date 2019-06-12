//
//  ParallaxCollectionViewController.swift
//  ParallaxSwift
//
//  Created by Grayson Stanton on 6/10/19.
//  Copyright © 2019 Grayson Stanton. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ParallaxCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var pics = [UIImage(named: "00"), UIImage(named: "01"), UIImage(named: "02"), UIImage(named: "03"), UIImage(named: "04"), UIImage(named: "05"), UIImage(named: "06"), UIImage(named: "07"), UIImage(named: "08"), UIImage(named: "09"), UIImage(named: "10")]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .black
        title = "Parallax!"
        collectionView!.register(ParallaxCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override convenience init(collectionViewLayout layout: UICollectionViewLayout) {
        self.init()
    }
    
    init() {
        let layout = ParallaxFlowLayout()
        let margin: CGFloat = 11.0
        layout.minimumLineSpacing = margin
        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let image = pics[indexPath.item]!
        
        let imageWidth: CGFloat = image.size.width
        let imageHeight: CGFloat = image.size.height
        
        let layout = collectionViewLayout as! ParallaxFlowLayout
        
        let cellWidth: CGFloat = collectionView.bounds.size.width - layout.sectionInset.left - layout.sectionInset.right
        let cellHeight = floor(cellWidth / imageWidth * imageHeight) - (2 * layout.maxParallaxOffset)
        return CGSize(width: cellWidth, height: cellHeight)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pics.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ParallaxCollectionViewCell
        let image = pics[indexPath.item]
        cell.imageView.image = image
        let layout = collectionViewLayout as! ParallaxFlowLayout
        cell.maxParallaxOffset = layout.maxParallaxOffset
        
        return cell
    }
}
