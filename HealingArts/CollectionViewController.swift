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
    var artCollection : [Artwork] = [Artwork]()
    var indexPath: IndexPath?
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
                self.getCollection()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! ArtworkCollectionViewCell
        let art = artCollection[indexPath.row]
        cell.imageView.image = art.images?.first
     //   cell.imageView.image = UIImage(named: images)
        cell.artistLabel.text = art.title
        
        return cell
    }
    
    func getCollection() {
        for artwork in artworks {
            if artwork.artist == artistName {
                artCollection.append(artwork)
                print(artwork.title)
            } else {
                print("duplicate")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.indexPath = indexPath
        performSegue(withIdentifier: "ArtworkSegue", sender: self)
    }
    
//prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! ArtDetailsViewController
        dvc.artwork = artworks[indexPath!.row]
//        indexOfArtwork = collectionView.indexPathsForSelectedItems?.first
//        let artwork = self.artworks[indexOfArtwork]
//        dvc.artwork = artwork
    }

}
