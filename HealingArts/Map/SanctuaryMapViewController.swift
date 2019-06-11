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

class SanctuaryMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var selectedArtwork : ArtworkItem?
    
    @IBOutlet weak var sanctuaryMapView: MKMapView!
    
    let reflectionRoom = ArtworkItem(name: "Reflection Room", artist: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.2554300, longitude: -95.9795720), imageName: "chihulySanctuary", distanceToUser: 0.0)
    let persianCeiling = ArtworkItem(name: "Azure and Jade Persian Ceiling", artist: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.255470, longitude: -95.9796490), imageName: "artPlaceholderImage", distanceToUser: 0.0)
    let iceTower = ArtworkItem(name: "Saphire Ice Tower", artist: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.255485, longitude: -95.9794816), imageName: "artPlaceholderImage", distanceToUser: 0.0)
    let hornetSconce = ArtworkItem(name: "Orange and Yellow Hornet Sconce", artist: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.255465, longitude: -95.9795660), imageName: "artPlaceholderImage", distanceToUser: 0.0)
    let rAndIDrawings = ArtworkItem(name: "Reed and Ikebana Drawings", artist: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.255510, longitude: -95.9795660), imageName: "artPlaceholderImage", distanceToUser: 0.0)
    let risingSun = ArtworkItem(name: "Rising Sun Sconce Wall", artist: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.2554280, longitude: -95.9795320), imageName: "artPlaceholderImage", distanceToUser: 0.0)
    let glassOnGlass = ArtworkItem(name: "Ikebana Glass on Glass Paintings", artist: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.2553880, longitude: -95.9794160), imageName: "artPlaceholderImage", distanceToUser: 0.0)
    let sunriseColumns = ArtworkItem(name: "Sunrise Persian Columns", artist: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.2553080, longitude: -95.9794735), imageName: "artPlaceholderImage", distanceToUser: 0.0)
    let floatDrawings = ArtworkItem(name: "Float and Basket Drawings", artist: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.2553230, longitude: -95.9795500), imageName: "artPlaceholderImage", distanceToUser: 0.0)
    let fioriSouth = ArtworkItem(name: "Mille Fiori", artist: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.2553500, longitude: -95.9795490), imageName: "artPlaceholderImage", distanceToUser: 0.0)
    let northEastFloat = ArtworkItem(name: "Nijima Floats", artist: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.255439, longitude: -95.979477), imageName: "artPlaceholderImage", distanceToUser: 0.0)
    let southEastFloat = ArtworkItem(name: "Nijima Floats", artist: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.255359, longitude: -95.979487), imageName: "artPlaceholderImage", distanceToUser: 0.0)
    let southWestFloat = ArtworkItem(name: "Nijima Floats", artist: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.255359, longitude: -95.979637), imageName: "artPlaceholderImage", distanceToUser: 0.0)
    let northWestFloat = ArtworkItem(name: "Nijima Floats", artist: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.255429, longitude: -95.979650), imageName: "artPlaceholderImage", distanceToUser: 0.0)
    let fioriNorthWest = ArtworkItem(name: "Mille Fiori", artist: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.255509, longitude: -95.979647), imageName: "artPlaceholderImage", distanceToUser: 0.0)
    let fioriNorthEast = ArtworkItem(name: "Mille Fiori", artist: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.255489, longitude: -95.9794160), imageName: "artPlaceholderImage", distanceToUser: 0.0)
    
    
    var artworks : [ArtworkItem] = []
    var sortedArtworks : [ArtworkItem] = []
    
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
        artworks.append(northEastFloat)
        artworks.append(southEastFloat)
        artworks.append(southWestFloat)
        artworks.append(northWestFloat)
        artworks.append(fioriNorthEast)
        artworks.append(fioriNorthWest)
        
        sanctuaryMapView.delegate = self
        
        let center = CLLocationCoordinate2D(latitude: 41.2553838, longitude: -95.9795296)
        let span = MKCoordinateSpan(latitudeDelta: 0.0003, longitudeDelta: 0.0003)
        let region = MKCoordinateRegion(center: center, span: span)
        sanctuaryMapView.setRegion(region, animated: false)
        
        for artwork in artworks{
            let annotation = MKPointAnnotation()
            annotation.coordinate = artwork.coordinate
            annotation.title = artwork.title
            //annotation.subtitle = "\(artwork.distanceToUser)"
            let annotaionView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
            annotaionView.alpha = 1.0
            sanctuaryMapView.addAnnotation(annotation)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        sanctuaryMapView.showsUserLocation = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        locationManager.stopUpdatingLocation()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation{
            //do nothing
        } else{
            let annotation = view.annotation as! MKPointAnnotation
            print (annotation.title!)
            for artwork in artworks{
                if artwork.title == annotation.title{
                    selectedArtwork = artwork
                }
            }
            performSegue(withIdentifier: "toArtworkDetailSegue", sender: nil)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ADVC =  segue.destination as! ArtDetailsViewController
        ADVC.artwork = selectedArtwork
    }
    
}
