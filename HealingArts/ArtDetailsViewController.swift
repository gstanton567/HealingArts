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

class ArtDetailsViewController: UIViewController, UIScrollViewDelegate{
    
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
    var imagePressed = false
    var pieceLocation : GeoPoint?
    var artist : Artist?
    var theImage = UIImage()
    
    
    var location = CLLocationCoordinate2D(latitude: 41.2554318, longitude: -95.9795596)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        setTextStyling()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(fromArtist)
        
        let tapGestureRecognizerForImage = UITapGestureRecognizer(target: self, action: #selector(ArtDetailsViewController.imageTapped(tapGestureRecognizerForImage:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizerForImage)
        
        

        artistButton.setTitleColor(UIColor.ChihulyUI.Blue.DeepAqua, for: .normal)
        mapButton.setTitleColor(UIColor.ChihulyUI.Blue.DeepAqua, for: .normal)
        barLabel.backgroundColor = UIColor.ChihulyUI.Blue.DeepAqua
        feedbackButton.tintColor = UIColor.ChihulyUI.Blue.DeepAqua
        
        if fromArtist{
            artistButton.isEnabled = false
            artistButton.setTitleColor(.black, for: .normal)
        } else{
            artistButton.isEnabled = true
        }
        
        //old code?
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
            theImage = (artworkPiece?.images!.first)!

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
            theImage = (artwork?.images!.first)!

        }
        
        //makes sure the artist button will actually go to an existing profile when tapped
        var isPermArtist = false
        for artist in Firebase.globalArtists {
            if (artist.name == artwork?.artist) {
                isPermArtist = true
            }
        }
        if !isPermArtist {
            artistButton.isEnabled = false
            artistButton.setTitleColor(UIColor(named: "black"), for: .normal)
        }
        setTextStyling()
    }
    

    func setTextStyling() {
        var italics = false
        var bold = false
        var italicSubStr = ""
        var boldSubStr = ""
        var totalText = ""
        

        var attributedString = NSMutableAttributedString(string:totalText)
        var normAttr = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]
        var italicAttr = [NSAttributedString.Key.font : UIFont.italicSystemFont(ofSize: 17)]
        var boldAttr = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]
        //var boldString = NSMutableAttributedString(string: boldSubStr, attributes: boldAttr)

        //attributedString.append(boldString)
        
        
       
        
        for word in descriptionTextView.text.split(separator: " ") {
            
            if (word == "$n") {
                //new line
                let newLineStr = "\n\n"
                var newLineAttributedString = NSMutableAttributedString(string:String(newLineStr), attributes: normAttr)
                attributedString.append(newLineAttributedString)
            }
            else if (word == "$i") {
                italics = true
            }
            else if (word == "$b") {
                bold = true
            }
            else if (word == "i$") {
                italics = false
                //totalText += italicSubStr + " "
                var italicString = NSMutableAttributedString(string: italicSubStr, attributes: italicAttr)
                attributedString.append(italicString)
                italicSubStr = ""
            }
            else if (word == "b$") {
                bold = false
                //totalText += boldSubStr + " "
                 var boldString = NSMutableAttributedString(string: boldSubStr, attributes: boldAttr)
                attributedString.append(boldString)
                boldSubStr = ""
            }
            else if (italics) {
                italicSubStr += word + " "
            }
            else if (bold) {
                boldSubStr += word + " "
            }
            else {
                //totalText += word
                let wordWithSpace = word + " "
                var normAttributedString = NSMutableAttributedString(string:String(wordWithSpace), attributes: normAttr)
                attributedString.append(normAttributedString)
            }
        }
        
        //print(attributedString)
        descriptionTextView.attributedText = attributedString
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        descriptionTextView.setContentOffset(CGPoint.zero, animated: false)
        setTextStyling()
    }
    
    
    // MARK: - Navigation
    
    
    //Artist info segue
    @IBAction func onArtistButtonPressed(_ sender: UIButton) {
        mapButtonPressed = false
        feedbackButtonPressed = false
        imagePressed = false
        performSegue(withIdentifier: "detailsToArtistDetailsSegue", sender: nil)
    }
    
    //Map button
    @IBAction func onMapButtonPressed(_ sender: UIButton) {
        mapButtonPressed = true
        feedbackButtonPressed = false
        imagePressed = false
        performSegue(withIdentifier: "detailsToSingleMapSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if !mapButtonPressed && !feedbackButtonPressed && !imagePressed{
            let avc = segue.destination as! ArtistDetailViewController
            avc.artworkPiece = artworkPiece
            avc.artist = artist
            print("art segue")
            
        } else if feedbackButtonPressed {
            let fvc = segue.destination as! FeedbackViewController
            //pass through name only?
            let artTitle = artwork?.title
            fvc.artTitle = artTitle
            print("feedback segue")
        } else if imagePressed {
            let zvc = segue.destination as! ZoomedArtworkViewController
            let artwork = theImage
            zvc.artwork = artwork
            print("zoom segue")
        } else {
            let smvc = segue.destination as! SingleArtworkMapViewController
            smvc.location = location
            smvc.sanctuaryPiece = sanctuaryPiece
            
        }
    }
    
    @objc func imageTapped(tapGestureRecognizerForImage: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizerForImage.view as! UIImageView
        imagePressed = true
        feedbackButtonPressed = false
        mapButtonPressed = false
        performSegue(withIdentifier: "detailsToZoomSegue", sender: nil)
        
    }
    

    @IBAction func onFeedbackButtonPressed(_ sender: Any) {
        feedbackButtonPressed = true
        mapButtonPressed = false
        imagePressed = false
        performSegue(withIdentifier: "detailsToFeedbackSegue", sender: nil)
        
    }
    
    
    
    
    
}
