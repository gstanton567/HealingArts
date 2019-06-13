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
    var artworks : [Artwork] = []
    
    
    var pics = [UIImage(named: "chihulypic"), UIImage(named: "CancerCenter"), UIImage(named: "kaneko"),UIImage(named: "chihulypic"), UIImage(named: "CancerCenter"), UIImage(named: "kaneko"),UIImage(named: "chihulypic"), UIImage(named: "CancerCenter"), UIImage(named: "gold")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        collectionView.backgroundColor = .black
        title = "Gallery"
        collectionView!.register(ParallaxCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        Firebase.getAllDocumentsInCollection { (artworks, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                self.artworks = artworks
                print (self.artworks.count)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override convenience init(collectionViewLayout layout: UICollectionViewLayout) {
        self.init()
    }
    
    init() {
        let layout = ParallaxFlowLayout()
        let margin: CGFloat = 5.0
        layout.minimumLineSpacing = margin
        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        let layout = ParallaxFlowLayout()
        let margin: CGFloat = 5.0
        layout.minimumLineSpacing = margin
        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        super.init(collectionViewLayout: layout)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let image = artworks[indexPath.item].images?.first!
        
        let imageWidth: CGFloat = image!.size.width
        let imageHeight: CGFloat = image!.size.height
        
        let layout = collectionViewLayout as! ParallaxFlowLayout
        
        let cellWidth: CGFloat = collectionView.bounds.size.width - layout.sectionInset.left - layout.sectionInset.right
        let cellHeight = floor(cellWidth / imageWidth * imageHeight) - (2 * layout.maxParallaxOffset)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artworks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ParallaxCollectionViewCell
        let image = artworks[indexPath.item].images?.first
        cell.imageView.image = image
        let layout = collectionViewLayout as! ParallaxFlowLayout
        cell.maxParallaxOffset = layout.maxParallaxOffset
        
        return cell
    }
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //
    //    }
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //
    //    }
    
    //adding sorting stuff here. Might need to add completion unless we want to update table view data in the function.
    
    //not working
    func sortByLoc(){
        sortedArtworks = []
        
        var distances : [Double] = []
        var distancesToSort : [Double] = []
        
        for artwork in artworks{
            let latitude = artwork.location?.latitude
            let longitude = artwork.location?.longitude
            let distance = self.locationManager.location?.distance(from: CLLocation(latitude: latitude!, longitude: longitude!))
            distances.append(distance!)
        }
        distancesToSort = distances
        distancesToSort.sort()
        
        for distanceMod in distancesToSort{
            for distance in distances{
                let indexOf = distances.firstIndex(of: distance)
                if distance == distanceMod{
                    let itemToAppend = artworks[indexOf!]
                    //may need to add a condition that makes sure we dont get a duplicate item if two things are equidistant from the user. Doubtful?
                    self.sortedArtworks.append(itemToAppend)
                }
            }
            //print statement to check if it worked
            for artwork in self.sortedArtworks{
                print ("Sorted Art: \(artwork.title!)")
            }
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    
}
