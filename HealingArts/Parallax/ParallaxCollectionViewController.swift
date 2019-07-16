//
//  ParallaxCollectionViewController.swift
//  ParallaxSwift
//
//  Created by Grayson Stanton on 6/10/19.
//  Copyright © 2019 Grayson Stanton. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

private let reuseIdentifier = "Cell"

class ParallaxCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    
    //sorting addition
    let locationManager = CLLocationManager()
    var sortedArtworks : [Artwork] = []
    
    var indexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = self.collectionViewLayout as! ParallaxFlowLayout
        let margin: CGFloat = 5.0
        layout.minimumLineSpacing = margin
        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        collectionView.backgroundColor = .black
        title = "Gallery"
        collectionView!.register(ParallaxCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        Firebase.getArtists { (artists, error) in
            if error != nil{
                print (error?.localizedDescription)
            } else {
                Firebase.globalArtists = artists
            }
        }
        
        Firebase.getMapArtworks { (mapArt, error) in
            if error != nil {
                print (error?.localizedDescription)
            } else {
                Firebase.globalMapArt = mapArt
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let image = Firebase.globalArtworks[indexPath.item].images?.first!
        
        let imageWidth: CGFloat = image!.size.width
        let imageHeight: CGFloat = image!.size.height
        
        let layout = collectionViewLayout as! ParallaxFlowLayout
        
        let cellWidth: CGFloat = collectionView.bounds.size.width - layout.sectionInset.left - layout.sectionInset.right
        let cellHeight = floor(cellWidth / imageWidth * imageHeight) - (2 * layout.maxParallaxOffset)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Firebase.globalArtworks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ParallaxCollectionViewCell
        let image = Firebase.globalArtworks[indexPath.item].images?.first
        cell.imageView.image = image
        let layout = collectionViewLayout as! ParallaxFlowLayout
        cell.maxParallaxOffset = layout.maxParallaxOffset
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.indexPath = indexPath
        performSegue(withIdentifier: "toArtwork", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! ArtDetailsViewController
        dvc.fromArtist = false
        dvc.artwork = Firebase.globalArtworks[self.indexPath!.row]
    }
    
    
}
