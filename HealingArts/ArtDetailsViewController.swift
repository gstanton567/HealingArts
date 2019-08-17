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
    var artwork : Artwork?
    
    @IBOutlet weak var barLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var artistButton: UIButton!
    @IBOutlet weak var pieceNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mediumLabel: UILabel!
    @IBOutlet weak var dimensionsLabel: UILabel!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var feedbackButton: UIButton!
    
    var sanctuaryPiece = false
    var fromArtist = false
    
    //dummy data from map
    var artworkPiece : Artwork?
    var selectedArtwork : ArtworkItem?
    var mapButtonPressed = false
    var feedbackButtonPressed = false
    var pieceLocation : GeoPoint?
    var artist : Artist?
    
    var location = CLLocationCoordinate2D(latitude: 41.2554318, longitude: -95.9795596)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(fromArtist)

        artistButton.setTitleColor(UIColor.ChihulyUI.Blue.DeepAqua, for: .normal)
        mapButton.setTitleColor(UIColor.ChihulyUI.Blue.DeepAqua, for: .normal)
        barLabel.backgroundColor = UIColor.ChihulyUI.Blue.DeepAqua
        
        if fromArtist{
            artistButton.isEnabled = false
            artistButton.setTitleColor(.black, for: .normal)
        } else{
            artistButton.isEnabled = true
        }
        
        
        if sanctuaryPiece{
            for artist in Firebase.globalArtists{
                if artist.name == artworkPiece?.artist{
                    self.artist = artist
                }
            }
            artistButton.setTitle(artworkPiece?.artist, for: .normal)
            let lat = artworkPiece?.location?.latitude
            let long = artworkPiece?.location?.longitude
            location = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
            pieceNameLabel.text = artworkPiece?.title
            mediumLabel.text = artworkPiece?.medium
            dimensionsLabel.text = artworkPiece?.dimensions
            dateLabel.text = artworkPiece?.date
            descriptionTextView.text = artworkPiece?.textDescription
            imageView.image = artworkPiece?.images?.first
        }
        else if artwork != nil {
            for artist in Firebase.globalArtists{
                if artist.name == artwork?.artist{
                    self.artist = artist
                }
            }
            artistButton.setTitle(artwork?.artist, for: .normal)
            pieceNameLabel.text = artwork?.title
            location = CLLocationCoordinate2D(latitude: (artwork?.location?.latitude)!, longitude: (artwork?.location?.longitude)!)
            artistButton.isEnabled = true
            imageView.image = artwork?.images?.first
            dateLabel.text = artwork?.date
            mediumLabel.text = artwork?.medium
            dimensionsLabel.text = artwork?.dimensions
            descriptionTextView.text = artwork?.textDescription
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
        feedbackButtonPressed = false
        performSegue(withIdentifier: "detailsToArtistDetailsSegue", sender: nil)
    }
    
    //Map button
    @IBAction func onMapButtonPressed(_ sender: UIButton) {
        mapButtonPressed = true
        feedbackButtonPressed = false
        performSegue(withIdentifier: "detailsToSingleMapSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if !mapButtonPressed && !feedbackButtonPressed{
            let avc = segue.destination as! ArtistDetailViewController
            avc.artworkPiece = artworkPiece
            avc.artist = artist
            print("art segue")
            
        } else if feedbackButtonPressed {
            let fvc = segue.destination as! FeedbackViewController
            //pass through name only?
            let artTitle = artworkPiece?.title
            fvc.artTitle = artTitle
            print("feedback segue")
        } else {
            let smvc = segue.destination as! SingleArtworkMapViewController
            smvc.location = location
            smvc.sanctuaryPiece = sanctuaryPiece
            print(pieceNameLabel.text)
        }
    }
    
    @IBAction func onFeedbackButtonPressed(_ sender: Any) {
        feedbackButtonPressed = true
        mapButtonPressed = false
        performSegue(withIdentifier: "detailsToFeedbackSegue", sender: nil)
        
    }
    
    
    
    
    
}
