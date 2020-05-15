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
    var artworkPiece : Artwork?
    var pinName : String?
    
    @IBOutlet weak var sanctuaryMapView: MKMapView!
    
    var sanctuaryPiece = true
    
    var artTitle = ""
    var pieceArtist = ""
    var pieceLocation : CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do we still need to get location???
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        sanctuaryMapView.delegate = self
        sanctuaryMapView.showsUserLocation = false
        
        //Creates detail map based on selected annotation.
        switch pinName!{
        case "Chihuly Sanctuary" :
            let center = CLLocationCoordinate2D(latitude: 41.2553360, longitude: -95.9795296)
            let span = MKCoordinateSpan(latitudeDelta: 0.0004, longitudeDelta: 0.0004)
            let region = MKCoordinateRegion(center: center, span: span)
            sanctuaryMapView.setRegion(region, animated: false)
            
            createOverlay(image: UIImage(named: "mapOverlayImage")!, origin: CLLocationCoordinate2D(latitude: 41.255530, longitude: -95.979840), size: MKMapSize(width: 410, height: 400))
            
            for artwork in Firebase.globalArtworks{
                if artwork.artist == "Dale Chihuly"{
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: artwork.location!.latitude, longitude: artwork.location!.longitude)
                    annotation.title = artwork.title
                    DispatchQueue.main.async{
                        self.sanctuaryMapView.addAnnotation(annotation)
                    }
                }
            }
        case "Lobby Artworks" :
            let center = CLLocationCoordinate2D(latitude: 41.255467, longitude: -95.979874)
            let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
            let region = MKCoordinateRegion(center: center, span: span)
            sanctuaryMapView.setRegion(region, animated: false)
            
            createOverlay(image: UIImage(named: "floorOneMap")!, origin: CLLocationCoordinate2D(latitude: 41.255867, longitude: -95.980234), size: MKMapSize(width: 1200, height: 760))
            
            for artwork in Firebase.globalArtworks{
                if artwork.floor == 0 {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: artwork.location!.latitude, longitude: artwork.location!.longitude)
                    annotation.title = artwork.title
                    DispatchQueue.main.async{
                        self.sanctuaryMapView.addAnnotation(annotation)
                    }
                }
                
            }
        case "Upper Lobby Artworks" :
            let center = CLLocationCoordinate2D(latitude: 41.255467, longitude: -95.979724)
            let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
            let region = MKCoordinateRegion(center: center, span: span)
            sanctuaryMapView.setRegion(region, animated: false)
            
            createOverlay(image: UIImage(named: "floorOneMap")!, origin: CLLocationCoordinate2D(latitude: 41.255867, longitude: -95.980234), size: MKMapSize(width: 1200, height: 760))
            
            for artwork in Firebase.globalArtworks{
                if artwork.floor == 1 {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: artwork.location!.latitude, longitude: artwork.location!.longitude)
                    annotation.title = artwork.title
                    DispatchQueue.main.async{
                        self.sanctuaryMapView.addAnnotation(annotation)
                    }
                }
                
            }
        default :
            break;
        }
        
    }
    
    /**
     Allows for easy creation of image overlays for the detail maps.
     */
    func createOverlay(image : UIImage?, origin: CLLocationCoordinate2D, size: MKMapSize){
        let mapRect = MKMapRect(origin: MKMapPoint(origin), size: size)
        let overlay = ImageOverlay(image: image!, rect: mapRect)
        print (overlay.coordinate)
        sanctuaryMapView.addOverlay(overlay)
    }
    
    /**
     Udpdates location when the detail map disappears.
    
     Not needed until we add becons???
     */
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        locationManager.stopUpdatingLocation()
    }
    
    /**
     Prep for segue to art details.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ADVC =  segue.destination as! DETAILSViewController
        ADVC.sanctuaryPiece = sanctuaryPiece
        ADVC.fromArtist = false
        ADVC.artworkPiece = artworkPiece
        ADVC.artwork = artworkPiece
    }
    
    /**
     Renders the image overlay for the detail map.
     */
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return ImageOverlayRenderer(overlay: overlay)
    }
    
    /**
     Handles what should be shown when an icon is clicked.
     */
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.image = UIImage(named: "artIcon")
        pin.canShowCallout = true
        pin.calloutOffset = CGPoint(x: 0, y: 25)
        let button = UIButton(type: .detailDisclosure)
        pin.rightCalloutAccessoryView = button
        
        if annotation.isEqual(mapView.userLocation) {
            return nil
        } else {
            return pin
        }
    }
    
    /**
     Handles the user pressing the info on an annotation.
     */
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("info button tapped")
        if view.annotation is MKUserLocation{
            //do nothing
        } else {
            let annotation = view.annotation as! MKPointAnnotation
            print (annotation.title!)
            for artwork in Firebase.globalArtworks{
                if artwork.title == annotation.title{
                    artworkPiece = artwork
                    print ("Selected Artwork Title is: \(artworkPiece!.title)")
                }
            }
            performSegue(withIdentifier: "toArtworkDetailSegue", sender: nil)
            }
        }
    

}
