//
//  ArtDetailsViewController.swift
//  HealingArts
//
//  Created by Gwyneth Semanisin on 6/10/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import FirebaseFirestore

class ArtDetailsViewController: UIViewController {
    
    @IBOutlet weak var barLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var artistButton: UIButton!
    @IBOutlet weak var pieceNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mediumLabel: UILabel!
    @IBOutlet weak var dimensionsLabel: UILabel!
    @IBOutlet weak var mapButton: UIButton!
    
    var sanctuaryPiece = false
    
    //dummy data from map
    var sanctuaryArtwork : Artwork?
    var selectedArtwork : ArtworkItem?
    var mapButtonPressed = false
    var pieceLocation : GeoPoint?
    
    var artwork: Artwork?
    
    var location = CLLocationCoordinate2D(latitude: 41.2554318, longitude: -95.9795596)
    
    let date = "2017-18"
    let medium = "Blown-glass"
    let dimensions = "2 x 8 1/2 x 16.5"
    let url = "https://s3.amazonaws.com/cdn.seattlemonorail.com/wp-content/uploads/2012/05/17003603/Chihuly03.jpg"
    let artDescription = "Chihuly's Sconces are wall installations composed of blown-glass elements that are created in responce to a specfic environment. The exterior-lit sculptures are influenced by the chandeliers of the grand homes and palaces throughout Europe from which Chihuly derived inspiration. Chihuly's blown-glass forms vary in color and form and frequently reference the natural world. In Chihuly's Orange and Yellow Hornet Sconce, the elements are referred to as 'hornets' due to their elongated shape, reminiscent of the insect's spiral rear section.\n\nAround the exterior of the Reflection Room, carefully arranged to complement the Orange and Yellow Hornet Sconce, is the Rising Sun Sconce Wall, composed of eight Sconces. Named for things found in nature, its elements include hornets, feathers, balls, and split leaves."
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.ChihulyUI.Gray.Graphite
        
//        descriptionTextView.layer.borderWidth = 1
//        descriptionTextView.layer.borderColor = UIColor.ChihulyCG.Gray.Pebblestone
        
        artistButton.setTitleColor(UIColor.ChihulyUI.Blue.DeepAqua, for: .normal)
        mapButton.setTitleColor(UIColor.ChihulyUI.Blue.DeepAqua, for: .normal)
        barLabel.backgroundColor = UIColor.ChihulyUI.Blue.DeepAqua
        
        let picURL = URL(string: url)
        let session = URLSession.shared
        let task = session.dataTask(with: picURL!) { (data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                self.imageView!.image = UIImage(data: data!)
            }
        }
        task.resume()
        
        if sanctuaryPiece{
            artistButton.setTitle(sanctuaryArtwork?.artist, for: .normal)
            pieceNameLabel.text = sanctuaryArtwork?.title
            pieceLocation = sanctuaryArtwork?.location
            dateLabel.text = sanctuaryArtwork?.date
            mediumLabel.text = sanctuaryArtwork?.medium
            dimensionsLabel.text = sanctuaryArtwork?.dimensions
            descriptionTextView.text = sanctuaryArtwork?.textDescription
        } else if selectedArtwork != nil {
            artistButton.setTitle(selectedArtwork?.artist, for: .normal)
            pieceNameLabel.text = selectedArtwork?.title
//            location = selectedArtwork!.coordinate
            dateLabel.text = date
            mediumLabel.text = medium
            dimensionsLabel.text = dimensions
            descriptionTextView.text = artDescription
        } else if artwork != nil {
            artistButton.setTitle(artwork?.artist, for: .normal)
//            location = artwork?.locatio
            
        }
        

    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        descriptionTextView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    
    // MARK: - Navigation
    
    
    //Artist info segue
    @IBAction func onArtistButtonPressed(_ sender: UIButton) {
        mapButtonPressed = false
        performSegue(withIdentifier: "detailsToArtistDetailsSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if !mapButtonPressed {
            let avc = segue.destination as! ArtistDetailViewController
            
            print("art boi button")
        }
        else{
            let smvc = segue.destination as! SingleArtworkMapViewController
            smvc.pieceLocation = pieceLocation
            smvc.location = location
            smvc.sanctuaryPiece = sanctuaryPiece
            print(pieceNameLabel.text)
            print("is map button")
        }
    }
    
    @IBAction func onMapButtonPressed(_ sender: UIButton) {
        mapButtonPressed = true
        performSegue(withIdentifier: "detailsToSingleMapSegue", sender: nil)
    }
    
    
    
    
}
