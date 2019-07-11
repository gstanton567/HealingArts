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
    
    @IBOutlet weak var sanctuaryMapView: MKMapView!
    
    var sanctuaryPiece = true
    
    
    var artTitle = ""
    var pieceArtist = ""
    var pieceLocation : CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createOverlay()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        sanctuaryMapView.delegate = self
        sanctuaryMapView.showsUserLocation = true
        
        let center = CLLocationCoordinate2D(latitude: 41.2553360, longitude: -95.9795296)
        let span = MKCoordinateSpan(latitudeDelta: 0.0004, longitudeDelta: 0.0004)
        let region = MKCoordinateRegion(center: center, span: span)
        sanctuaryMapView.setRegion(region, animated: false)
        
        for artwork in Firebase.globalArtworks{
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: artwork.location!.latitude, longitude: artwork.location!.longitude)
            annotation.title = artwork.title
            DispatchQueue.main.async{
                self.sanctuaryMapView.addAnnotation(annotation)
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        locationManager.stopUpdatingLocation()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ADVC =  segue.destination as! ArtDetailsViewController
        ADVC.sanctuaryPiece = sanctuaryPiece
        ADVC.fromArtist = false
        ADVC.artworkPiece = artworkPiece
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return ImageOverlayRenderer(overlay: overlay)
    }
    
    func createOverlay(){
        let mapRect = MKMapRect(origin: MKMapPoint(CLLocationCoordinate2D(latitude: 41.255530, longitude: -95.979840)), size: MKMapSize(width: 410, height: 400))
        let overlay = ImageOverlay(image: UIImage(named: "mapOverlayImage")!, rect: mapRect)
        print (overlay.coordinate)
        sanctuaryMapView.addOverlay(overlay)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.image = UIImage(named: "artIcon")
        pin.canShowCallout = true
        let button = UIButton(type: .detailDisclosure)
        pin.rightCalloutAccessoryView = button
        
        if annotation.isEqual(mapView.userLocation) {
            return nil
        } else {
            return pin
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("info button tapped")
        if view.annotation is MKUserLocation{
            //do nothing
        } else{
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
