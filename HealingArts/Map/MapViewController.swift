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
   
    @IBOutlet weak var floorController: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
 
    var sanctuaryPiece = false
    
    var selectedArtwork : Artwork?
    
    var pinName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Map"
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        
        for artwork in Firebase.globalMapArt{
            if artwork.floor == 0{
                DispatchQueue.main.async {
                    self.createPin(location: CLLocationCoordinate2D(latitude: artwork.location!.latitude, longitude: artwork.location!.longitude))
                }
            } else {
                //do nothing
            }
        }
        
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        switch
        floorController.selectedSegmentIndex{
        case 0:
            mapView.removeAnnotations(mapView.annotations)
            for artwork in Firebase.globalMapArt{
                if artwork.floor == 0 {
                    DispatchQueue.main.async {
                        self.createPin(location: CLLocationCoordinate2D(latitude: artwork.location!.latitude, longitude: artwork.location!.longitude))
                    }
                }
            }
        case 1:
            mapView.removeAnnotations(mapView.annotations)
            for artwork in Firebase.globalMapArt{
                if artwork.floor == 1 {
                    DispatchQueue.main.async {
                        self.createPin(location: CLLocationCoordinate2D(latitude: artwork.location!.latitude, longitude: artwork.location!.longitude))
                    }
                }
            }

        case 2:
            mapView.removeAnnotations(mapView.annotations)
            for artwork in Firebase.globalMapArt{
                if artwork.floor == 2 {
                    DispatchQueue.main.async {
                        self.createPin(location: CLLocationCoordinate2D(latitude: artwork.location!.latitude, longitude: artwork.location!.longitude))
                    }
                }
            }

        case 3:
            mapView.removeAnnotations(mapView.annotations)
            for artwork in Firebase.globalMapArt{
                if artwork.floor == 4 {
                    DispatchQueue.main.async {
                        self.createPin(location: CLLocationCoordinate2D(latitude: artwork.location!.latitude, longitude: artwork.location!.longitude))
                    }
                }
            }

        default:
            break
        }
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
        //checks the coordinate of each artwork to see if it is equal to the coordinate of the selected pinb
        for artwork in Firebase.globalMapArt{
            if artwork.location?.latitude == location?.latitude && artwork.location?.longitude == location?.longitude{
                self.selectedArtwork = artwork
                pinName = artwork.title!
                
                let alertController = UIAlertController(title: artwork.title, message: "", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel) { (UIAlertAction) in
                    print ("OK")
                    mapView.deselectAnnotation(annotation, animated: true)
                }
                let detailAction = UIAlertAction(title: "Details", style: .default) { (UIAlertAction) in
                    if artwork.title == "Search" || artwork.title == "Leslie's Healing Garden"{
                        self.performSegue(withIdentifier: "toArtworkDetailSegue", sender: nil)
                    } else{
                        self.performSegue(withIdentifier: "toSanctuaryMap", sender: nil)
                    }
                    self.mapView.deselectAnnotation(view.annotation, animated: true)
                }
                alertController.addAction(okAction)
                alertController.addAction(detailAction)
                
                let imageView = UIImageView(frame: CGRect(x: 10, y: 20, width: 250, height: 230))
                imageView.image = artwork.images?.first
                imageView.contentMode = .scaleAspectFit
                alertController.view.addSubview(imageView)
                
                //trying to get the right spacing for the image. not quite working.
                //only really works with rectangular images that have width > height
                var artworkArtistString = ""
                let imageSize = imageView.frame.height
                //17.75 = magic number???
                let numberOfLines = Double(imageSize / 17.75)
                let numberOfLinesInt = Int(numberOfLines)
                for _ in 1...numberOfLinesInt{
                    artworkArtistString.append("\n")
                }
                artworkArtistString.append(artwork.artist!)
                
                //set message after it is created. Replaces Empty String.
                alertController.message = artworkArtistString
                
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toArtworkDetailSegue"{
            let ADVC =  segue.destination as! ArtDetailsViewController
            sanctuaryPiece = false
            ADVC.artwork = selectedArtwork
            ADVC.fromArtist = true
            ADVC.sanctuaryPiece = sanctuaryPiece
        } else {
            //may or may not need
            let SMVC = segue.destination as! SanctuaryMapViewController
            sanctuaryPiece = true
            SMVC.sanctuaryPiece = sanctuaryPiece
            SMVC.locationManager = locationManager
            SMVC.pinName = pinName
        }
        
    }

}
