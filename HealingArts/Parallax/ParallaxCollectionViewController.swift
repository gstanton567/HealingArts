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
    
    var artworksMod : [Artwork] = []

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
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let image = artworksMod[indexPath.item].images?.first!
        var imageSizeMultiplier = 1.0
        if (artworksMod[indexPath.item].title == "Autumn Leaves Persian Installation")
        {
            imageSizeMultiplier = 3
        }
        if (artworksMod[indexPath.item].title == "The Hope Tapestry")
        {
            imageSizeMultiplier = (1/1.5)
        }
        
        let imageWidth: CGFloat = image!.size.width
        let imageHeight: CGFloat = image!.size.height
        
        let layout = collectionViewLayout as! ParallaxFlowLayout
        
        let cellWidth: CGFloat = collectionView.bounds.size.width - layout.sectionInset.left - layout.sectionInset.right
        var cellHeight = (floor(cellWidth / imageWidth * imageHeight) - (2 * layout.maxParallaxOffset))
        if(cellHeight * 1.5 < 500)
        {
            cellHeight = cellHeight * 1.5
        }
        cellHeight = cellHeight * CGFloat(imageSizeMultiplier)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //sorts out duplicate images before returning a count
        //currently DOES NOT remove artworks w/o proper data
        
        var isDuplicate = false
        for artwork in Firebase.globalArtworks{
            isDuplicate = false
            for modArtwork in artworksMod{
                if (modArtwork.textDescription == artwork.textDescription && artwork.title == "Niijima Floats") {
                    print(artwork.title!)
                    isDuplicate = true
                }
            }
            if isDuplicate == false {
                artworksMod.append(artwork)
            }
        }
        
        // boolean to deal with duplicate chihuly
        var chihulyAdded = false;
        for artwork in Firebase.globalMapArt{
            if (artwork.title != "Upper Lobby Artworks" && artwork.title != "Lobby Artworks"){
                if (artwork.title == "Chihuly Sanctuary"){
                    if (!chihulyAdded){
                        artworksMod.append(artwork)
                        chihulyAdded = true
                    }
                } else {
                    artworksMod.append(artwork)
                }
            }
        }
        Firebase.globalModArtworks = artworksMod
        return artworksMod.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ParallaxCollectionViewCell
        let image = artworksMod[indexPath.item].images?.first
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
        dvc.artwork = artworksMod[self.indexPath!.row]
    }
    
    
}
