//
//  SanctuaryMapViewController.swift
//  HealingArts
//
//  Created by Keegan Brown on 6/10/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class SanctuaryMapViewController: UIViewController {
    
    @IBOutlet weak var sanctuaryMapView: MKMapView!
    
     let reflectionRoom = ArtworkItem(name: "Reflection Room", desc: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.2554300, longitude: -95.9795720), imageName: "chihulySanctuary")
    let persianCeiling = ArtworkItem(name: "Azure and Jade Persian Ceiling", desc: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.255470, longitude: -95.9796516), imageName: "artPlaceholderImage")
    
    var artworks : [ArtworkItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        artworks.append(reflectionRoom)
        artworks.append(persianCeiling)

        let center = CLLocationCoordinate2D(latitude: 41.2553838, longitude: -95.9795296)
        let span = MKCoordinateSpan(latitudeDelta: 0.0003, longitudeDelta: 0.0003)
        let region = MKCoordinateRegion(center: center, span: span)
        sanctuaryMapView.setRegion(region, animated: false)
        
        for artwork in artworks{
            let annotation = MKPointAnnotation()
            annotation.coordinate = artwork.coordinate
            annotation.title = artwork.title
            sanctuaryMapView.addAnnotation(annotation)
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
