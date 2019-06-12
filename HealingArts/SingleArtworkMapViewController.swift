//
//  SingleArtworkMapViewController.swift
//  HealingArts
//
//  Created by Gwyneth Semanisin on 6/10/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Firebase
import FirebaseFirestore

class SingleArtworkMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var sanctuaryPiece = false
    
    let locationManager = CLLocationManager()
    //dummy location rn
    var location = CLLocationCoordinate2D()
    var pieceLocation : GeoPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if sanctuaryPiece{
            location.latitude = pieceLocation!.latitude
            location.longitude = pieceLocation!.longitude
        }
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        createPin(location: location)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let span = MKCoordinateSpan(latitudeDelta: 0.00135, longitudeDelta: 0.00135)
        let center = CLLocationCoordinate2D(latitude: 41.2555318, longitude: -95.979859999)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        locationManager.startUpdatingLocation()
        print ("getting location")
        mapView.showsUserLocation = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        locationManager.stopUpdatingLocation()
        print ("Location is no longer updating")
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation
        let location = annotation?.coordinate
    }
    
    func createPin (location : CLLocationCoordinate2D?){
        let annotation = MKPointAnnotation()
        annotation.coordinate = location!
        print(annotation.coordinate)
        mapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        let image = UIImage(named: "artIcon")
        pin.image = image
        
        if annotation.isEqual(mapView.userLocation) {
            return nil
        } else {
            return pin
        }
    }
    
}
