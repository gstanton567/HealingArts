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
    var selectedArtwork : Artwork?
    
    @IBOutlet weak var sanctuaryMapView: MKMapView!
    
    
    var artworks : [Artwork] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        sanctuaryMapView.delegate = self
        sanctuaryMapView.showsUserLocation = true
        
        let center = CLLocationCoordinate2D(latitude: 41.2553838, longitude: -95.9795296)
        let span = MKCoordinateSpan(latitudeDelta: 0.0003, longitudeDelta: 0.0003)
        let region = MKCoordinateRegion(center: center, span: span)
        sanctuaryMapView.setRegion(region, animated: false)
        
        Firebase.getAllDocumentsInCollection(completion: { (artworks, error) in
            print (artworks.count)
            for artwork in artworks{
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: artwork.location!.latitude, longitude: artwork.location!.longitude)
                annotation.title = artwork.title
                let annotaionView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
                annotaionView.alpha = 1.0
                self.sanctuaryMapView.addAnnotation(annotation)
            }
        })
        
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
