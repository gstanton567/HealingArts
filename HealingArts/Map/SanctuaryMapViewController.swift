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
    let iceTower = ArtworkItem(name: "Saphire Ice Tower", desc: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.255485, longitude: -95.9794816), imageName: "artPlaceholderImage")
    let hornetSconce = ArtworkItem(name: "Orange and Yellow Hornet Sconce", desc: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.255465, longitude: -95.9795660), imageName: "artPlaceholderImage")
    let rAndIDrawings = ArtworkItem(name: "Reed and Ikebana Drawings", desc: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.255510, longitude: -95.9795660), imageName: "artPlaceholderImage")
    let risingSun = ArtworkItem(name: "Rising Sun Sconce Wall", desc: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.2554280, longitude: -95.9795320), imageName: "artPlaceholderImage")
    let glassOnGlass = ArtworkItem(name: "Ikebana Glass on Glass Paintings", desc: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.2553880, longitude: -95.9794160), imageName: "artPlaceholderImage")
    let sunriseColumns = ArtworkItem(name: "Sunrise Persian Columns", desc: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.2553080, longitude: -95.9794735), imageName: "artPlaceholderImage")
    let floatDrawings = ArtworkItem(name: "Float and Basket Drawings", desc: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.2553280, longitude: -95.9795460), imageName: "artPlaceholderImage")
    let fioriSouth = ArtworkItem(name: "Mille Fiori", desc: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.2553500, longitude: -95.9795490), imageName: "artPlaceholderImage")
    
    
    var artworks : [ArtworkItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        artworks.append(reflectionRoom)
        artworks.append(persianCeiling)
        artworks.append(iceTower)
        artworks.append(hornetSconce)
        artworks.append(rAndIDrawings)
        artworks.append(risingSun)
        artworks.append(glassOnGlass)
        artworks.append(sunriseColumns)
        artworks.append(floatDrawings)
        artworks.append(fioriSouth)

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
