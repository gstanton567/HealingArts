//
//  MapViewController.swift
//  HealingArts
//
//  Created by Keegan Brown on 6/7/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    //41.2555318
    //-95.9804596
    
    let artCoordinate1 = CLLocationCoordinate2D(latitude: 41.2555318, longitude: -95.9804596)
    let artCoordinate2 = CLLocationCoordinate2D(latitude: 41.2556318, longitude: -95.9801596)
    //approximately over the Chihuly Sanctuary Reflection Room
    let artCoordinate3 = CLLocationCoordinate2D(latitude: 41.2554318, longitude: -95.9795596)
    //approximate coordinate of "Search" by Kaneko
    let artCoordinate4 = CLLocationCoordinate2D(latitude: 41.2560330, longitude: -95.9804196)
    //approximate location of Leslie's Healing Garden
    let artCoordinate5 = CLLocationCoordinate2D(latitude: 41.2552318, longitude: -95.9796596)

    var artCoordinates : [CLLocationCoordinate2D]? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        artCoordinates?.append(artCoordinate1)
        artCoordinates?.append(artCoordinate2)
        artCoordinates?.append(artCoordinate3)
        artCoordinates?.append(artCoordinate4)
        artCoordinates?.append(artCoordinate5)
        
        for coordinate in artCoordinates! {
            createPin(location: coordinate)
            print ("added pin")
        }
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
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let center = userLocation.coordinate
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let alertController = UIAlertController(title: "art title", message: "\n\n\n\n\n\n\n\n\n\n\n"+"art info", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (UIAlertAction) in
            print ("OK")
        }
        let detailAction = UIAlertAction(title: "Details", style: .default) { (UIAlertAction) in
            self.locationManager.stopUpdatingLocation()
            print ("Show details. Location is no longer updating.")
            //add possible perform segue???
        }
        alertController.addAction(okAction)
        alertController.addAction(detailAction)
        let imageView = UIImageView(frame: CGRect(x: 10, y: 15, width: 250, height: 230))
        imageView.image = UIImage(named: "artPlaceholderImage")
        imageView.contentMode = .scaleAspectFit
        alertController.view.addSubview(imageView)
        self.present(alertController, animated: true)
    }
    
    //image may be optional
    func createPin (location : CLLocationCoordinate2D?/*, icon : UIImage?*/){
        let annotation = MKPointAnnotation()
        annotation.coordinate = location!
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
