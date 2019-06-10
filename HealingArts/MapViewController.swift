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
    
    //Hospital Coordinates
    //41.2555318
    //-95.9804596
    
    //additional coordinates. Probably won't need them.
    //let artCoordinate1 = CLLocationCoordinate2D(latitude: 41.2555318, longitude: -95.9804596)
    //let artCoordinate2 = CLLocationCoordinate2D(latitude: 41.2556318, longitude: -95.9801596)

    var artworks : [AnnotationItem]? = []
    
    let art1 = AnnotationItem(name: "Chihuly Sanctuary", desc: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.2554318, longitude: -95.9795596), imageName: "chihulySanctuary")
    let art2 = AnnotationItem(name: "Search", desc: "Jun Kaneko", coordinate: CLLocationCoordinate2D(latitude: 41.2560330, longitude: -95.9804196), imageName: "search")
    let art3 = AnnotationItem(name: "Leslie's Healing Garden", desc: "A neat garden", coordinate: CLLocationCoordinate2D(latitude: 41.2552318, longitude: -95.9796596), imageName: "lesliesHealingGarden")
    
    var selectedArtwork : AnnotationItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        artworks?.append(art1)
        artworks?.append(art2)
        artworks?.append(art3)
        
        for artwork in artworks!{
            createPin(location: artwork.coordinate)
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
        let span = MKCoordinateSpan(latitudeDelta: 0.00135, longitudeDelta: 0.00135)
        let center = CLLocationCoordinate2D(latitude: 41.2555318, longitude: -95.979859999)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: false)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation
        let location = annotation?.coordinate
        //checks the coordinate of each artwork to see if it is equal to the coordinate of the selected pinb
        for artwork in artworks!{
            if artwork.coordinate.latitude == location?.latitude && artwork.coordinate.longitude == location?.longitude{
                self.selectedArtwork = artwork
                
                let alertController = UIAlertController(title: artwork.title, message: "", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel) { (UIAlertAction) in
                    print ("OK")
                }
                let detailAction = UIAlertAction(title: "Details", style: .default) { (UIAlertAction) in
                    self.performSegue(withIdentifier: "toMapDetailSegue", sender: nil)
                    self.mapView.deselectAnnotation(view.annotation, animated: true)
                }
                alertController.addAction(okAction)
                alertController.addAction(detailAction)
                
                let imageView = UIImageView(frame: CGRect(x: 10, y: 20, width: 250, height: 230))
                imageView.image = UIImage(named: artwork.imageName)
                imageView.contentMode = .scaleAspectFit
                alertController.view.addSubview(imageView)
                
                //trying to get the right spacing for the image. not quite working.
                //only really works with rectangular images that have width > height
                var artworkDescString = ""
                let imageSize = imageView.frame.height
                let numberOfLines = Double(imageSize / 18)
                let numberOfLinesInt = Int(numberOfLines)
                for _ in 1...numberOfLinesInt{
                    artworkDescString.append("\n")
                }
                artworkDescString.append(artwork.desc)
                
                //set message after it is created. Replaces Empty String.
                alertController.message = artworkDescString
                
                self.present(alertController, animated: true)
            }
        }
    }
    
    func createPin (location : CLLocationCoordinate2D?){
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
    
    @IBAction func unwindToMapViewController(segue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let MDVC =  segue.destination as! MapDetailViewController
        MDVC.artwork = selectedArtwork
    }

}
