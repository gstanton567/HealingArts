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
    
    //just using this for now to see items outside of sanctuary
    var sanctuaryPiece = false
    
    var artworks = Firebase.globalMapArt
    var selectedArtwork : Artwork?

    //let art1 = ArtworkItem(name: "Chihuly Sanctuary", artist: "Dale Chihuly", coordinate: CLLocationCoordinate2D(latitude: 41.2554318, longitude: -95.9795596), imageName: "chihulySanctuary", distanceToUser: 0.0)
    //let art2 = ArtworkItem(name: "Search", artist: "Jun Kaneko", coordinate: CLLocationCoordinate2D(latitude: 41.2560330, longitude: -95.9804196), imageName: "search", distanceToUser: 0.0)
   // let art3 = ArtworkItem(name: "Leslie's Healing Garden", artist: "" /* N/A */, coordinate: CLLocationCoordinate2D(latitude: 41.2552318, longitude: -95.9796596), imageName: "lesliesHealingGarden", distanceToUser: 0.0)
    
    //need to figure out how to make geopoints
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Map"
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        
        for artwork in artworks{
            if artwork.floor == 0{
                createPin(location: CLLocationCoordinate2D(latitude: artwork.location!.latitude, longitude: artwork.location!.longitude))
            } else {
                //do nothing
            }
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
        for artwork in artworks{
            if artwork.location?.latitude == location?.latitude && artwork.location?.longitude == location?.longitude{
                self.selectedArtwork = artwork
                
                let alertController = UIAlertController(title: artwork.title, message: "", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel) { (UIAlertAction) in
                    print ("OK")
                    mapView.deselectAnnotation(annotation, animated: true)
                }
                let detailAction = UIAlertAction(title: "Details", style: .default) { (UIAlertAction) in
                    if artwork.title == "Chihuly Sanctuary"{
                        self.performSegue(withIdentifier: "toSanctuaryMap", sender: nil)
                    } else{
                        self.performSegue(withIdentifier: "toArtworkDetailSegue", sender: nil)
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
        }
        
    }

}
