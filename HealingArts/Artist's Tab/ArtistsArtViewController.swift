//
//  ArtistsArtViewController.swift
//  HealingArts
//
//  Created by Justine Linscott on 6/10/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit

class ArtistsArtViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
   
    var chihulyArt = ["flowers", "garden", "reflective"]

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Collection"
        collectionView.allowsSelection = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chihulyArt.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! artCollectionViewCell
        cell.imageView.image = (UIImage(named: chihulyArt[indexPath.row]))
        return cell
    }
}
