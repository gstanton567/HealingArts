//
//  CollectionViewController.swift
//  HealingArts
//
//  Created by Justine Linscott on 6/12/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var artistName: String!
    var artworks : [Artwork] = [Artwork]()
    var artCollection : [String] = []
    let collection : [String] = ["chihulySanctuary", "search", "harnoor", "gold"]

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.allowsSelection = true
        title = "Collection"
        //gets data
        Firebase.getAllDocumentsInCollection { (artworks, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                self.artworks = artworks
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.getCollection()
                }
            }
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! ArtworkCollectionViewCell
       // let images = collection[indexPath.row]
        let art = artCollection[indexPath.row]
     //   cell.imageView.image = UIImage(named: images)
        cell.artistLabel.text = art
        
        return cell
    }
    
    func getCollection() {
        for artwork in artworks {
            if artwork.artist == artistName {
                artCollection.append(artwork.title!)
            }
        }
    }

}
