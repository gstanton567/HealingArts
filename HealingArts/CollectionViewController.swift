//
//  CollectionViewController.swift
//  HealingArts
//
//  Created by Justine Linscott on 6/12/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let collection : [String] = ["chihulySanctuary", "search"]

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.allowsSelection = true
        title = "Collection"
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
        //cell.imageView
        return cell
    }

}
