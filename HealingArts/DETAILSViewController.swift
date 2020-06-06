//
//  DETAILSViewController.swift
//  HealingArts
//
//  Created by Carly Cameron on 5/13/20.
//  Copyright © 2020 Brady Fehr. All rights reserved.
//

import UIKit

import CoreLocation
import Firebase
import FirebaseFirestore

class DETAILSViewController: UIViewController {

    var fromArtist: Bool!
    var artwork: Artwork!
    var sanctuaryPiece = false
    var artworkPiece: Artwork!
    
    var mapButtonPressed = false
    var feedbackButtonPressed = false
    var imagePressed = false
    var theImage = UIImage()
    //var pieceLocation : GeoPoint?
    var artist : Artist?
    
    var location = CLLocationCoordinate2D(latitude: 41.2554318, longitude: -95.9795596)
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var donorLabel: UILabel!
    @IBOutlet weak var dimensionLabel: UILabel!
    @IBOutlet weak var mediumLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    //dont really need the outlet for this button
    @IBOutlet weak var artistButton: UIButton!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGestureRecognizerForImage = UITapGestureRecognizer(target: self, action: #selector(ArtDetailsViewController.imageTapped(tapGestureRecognizerForImage:)))
               imageView.isUserInteractionEnabled = true
               imageView.addGestureRecognizer(tapGestureRecognizerForImage)
               

        if sanctuaryPiece{
            for artist in Firebase.globalArtists{
                if artist.name == artworkPiece?.artist{
                    self.artist = artist
                }
            }
            if artworkPiece.date != "" {
                dateLabel.text = artworkPiece.date
            }
            if artworkPiece.artist != "" {
                artistLabel.text = artworkPiece.artist
            }
            if artworkPiece.title != "" {
                titleLabel.text = artworkPiece.title
            }
            if artworkPiece.medium != "" {
                mediumLabel.text = artworkPiece.medium
            }
            
            
            if artworkPiece.dimensions != "" && artworkPiece.dimensions != nil {
                dimensionLabel.text = artworkPiece.dimensions
            }
            if artworkPiece.donor != "" {
                donorLabel.text = artworkPiece.donor
            }
            
            descriptionLabel.text = artworkPiece.textDescription
            
            imageView.image = artworkPiece.images?.first
            
           
            let lat = artworkPiece?.location?.latitude
            let long = artworkPiece?.location?.longitude
            location = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
            theImage = (artworkPiece?.images!.first)!

        }
        else if artwork != nil {
            for artist in Firebase.globalArtists{
                if artist.name == artwork?.artist{
                    self.artist = artist
                }
            }
            if artwork.date != "" {
                dateLabel.text = artwork.date
            }
            if artwork.artist != "" {
                artistLabel.text = artwork.artist
            }
            if artwork.title != "" {
                titleLabel.text = artwork.title
            }
            if artwork.medium != "" {
                mediumLabel.text = artwork.medium
            }
            
            print(artwork.dimensions as Any)
            if artwork.dimensions != "" && artwork.dimensions != nil {
                dimensionLabel.text = artwork.dimensions
            }
            if artwork.donor != "" {
                donorLabel.text = artwork.donor
            }
            
            descriptionLabel.text = artwork.textDescription
            
            imageView.image = artwork.images?.first
            
            location = CLLocationCoordinate2D(latitude: (artwork?.location?.latitude)!, longitude: (artwork?.location?.longitude)!)
            artistButton.isEnabled = true
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
        
        if fromArtist{
            artistButton.isEnabled = false
            artistButton.setTitleColor(.black, for: .normal)
        } else{
            artistButton.isEnabled = true
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
          
          
         
          
        for word in descriptionLabel.text!.split(separator: " ") {
              
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
          descriptionLabel.attributedText = attributedString
      }
    
    @IBAction func onArtistButtonPressed(_ sender: Any) {
        print("segue to artist")
        mapButtonPressed = false
        feedbackButtonPressed = false
        imagePressed = false
        performSegue(withIdentifier: "detailsToArtistDetailsSegue", sender: nil)
    }
    
    @IBAction func onMapButtonPressed(_ sender: Any) {
        print("segue to map")
        mapButtonPressed = true
        feedbackButtonPressed = false
        imagePressed = false
        performSegue(withIdentifier: "detailsToSingleMapSegue", sender: nil)
    }
    
    @IBAction func onFeedbackButtonPressed(_ sender: Any) {
        print("segue to feedback")
        feedbackButtonPressed = true
        mapButtonPressed = false
        imagePressed = false
        performSegue(withIdentifier: "detailsToFeedbackSegue", sender: nil)
    }
    
    @objc func imageTapped(tapGestureRecognizerForImage: UITapGestureRecognizer) {
           let tappedImage = tapGestureRecognizerForImage.view as! UIImageView
           imagePressed = true
           feedbackButtonPressed = false
           mapButtonPressed = false
           performSegue(withIdentifier: "detailsToZoomSegue", sender: nil)
           
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
