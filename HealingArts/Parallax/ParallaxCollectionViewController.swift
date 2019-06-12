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

    
    var pics = [UIImage(named: "chihulypic"), UIImage(named: "CancerCenter"), UIImage(named: "kaneko"),UIImage(named: "chihulypic"), UIImage(named: "CancerCenter"), UIImage(named: "kaneko"),UIImage(named: "chihulypic"), UIImage(named: "CancerCenter"), UIImage(named: "gold")]
    
    //sorting addition
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        locationManager.startUpdatingLocation()
        sortByLoc()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        collectionView.backgroundColor = .black
        title = "Gallery"
        collectionView!.register(ParallaxCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

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
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    }
    
    //adding sorting stuff here
    func sortByLoc(){
        var distances : [Double] = []
        var distancesMod : [Double] = []
        
        var artworksToSort : [Artwork] = []
        
        Firebase.getAllDocumentsInCollection { (artworks, error) in
            for artwork in artworks{
                artworksToSort.append(artwork)
                let latitude = artwork.location?.latitude
                let longitude = artwork.location?.longitude
                let distance = self.locationManager.location?.distance(from: CLLocation(latitude: latitude!, longitude: longitude!))
                distances.append(distance!)
            }
            distancesMod = distances
            distancesMod.sort()
            
            for distanceMod in distancesMod{
                for distance in distances{
                    let indexOf = distances.firstIndex(of: distance)
                    if distance == distanceMod{
                        self.sortedArtworks.append(artworksToSort[indexOf!])
                    }
                }
            }
            
            for artwork in self.sortedArtworks{
                print ("\(artwork.title!)")
            }
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    
}
