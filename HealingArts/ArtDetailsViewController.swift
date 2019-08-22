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
    @IBOutlet weak var tintImageView: UIImageView!
    @IBOutlet weak var imageDetailScrollView: UIScrollView!
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
    
    var imageViewForScrolling = UIImageView()
    
    var location = CLLocationCoordinate2D(latitude: 41.2554318, longitude: -95.9795596)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        imageDetailScrollView.delegate = self
        imageViewForScrolling = UIImageView(image: UIImage(named: "artPlaceholderImage"))
        imageDetailScrollView.backgroundColor = .black
        imageDetailScrollView.contentSize = imageViewForScrolling.bounds.size
        imageDetailScrollView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
        imageDetailScrollView.contentOffset = CGPoint(x: 1090, y: 450)
        imageDetailScrollView.isUserInteractionEnabled = true

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(fromArtist)
        
        let tapGestureRecognizerForImage = UITapGestureRecognizer(target: self, action: #selector(ArtDetailsViewController.imageTapped(tapGestureRecognizerForImage:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizerForImage)
        
        let tapGestureRecognizerForTint = UITapGestureRecognizer(target: self, action: #selector(ArtDetailsViewController.tintTapped(tapGestureRecognizerForTint:)))
        
        tintImageView.isUserInteractionEnabled = true
        tintImageView.addGestureRecognizer(tapGestureRecognizerForTint)

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
            imageViewForScrolling = UIImageView(image: (artworkPiece?.images?.first))
            imageDetailScrollView.addSubview(imageViewForScrolling)

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
            imageViewForScrolling = UIImageView(image: (artwork?.images?.first))
            imageDetailScrollView.addSubview(imageViewForScrolling)

        }
        
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageViewForScrolling
    }
    
    func setZoomScale(){
        let imageViewSize = imageViewForScrolling.bounds.size
        let scrollViewSize = imageDetailScrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        imageDetailScrollView.minimumZoomScale = min(widthScale, heightScale)
        imageDetailScrollView.zoomScale = 1.0
    }
    
    override func viewWillLayoutSubviews() {
        setZoomScale()
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
            let artTitle = artwork?.title
            fvc.artTitle = artTitle
            print("feedback segue")
        } else {
            let smvc = segue.destination as! SingleArtworkMapViewController
            smvc.location = location
            smvc.sanctuaryPiece = sanctuaryPiece
            print(pieceNameLabel.text)
        }
    }
    
    @objc func imageTapped(tapGestureRecognizerForImage: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizerForImage.view as! UIImageView
        
        imageDetailScrollView.isHidden = false
        tintImageView.isHidden = false
        
    }
    
    @objc func tintTapped(tapGestureRecognizerForTint : UIGestureRecognizer) {
        let tappedItem = tapGestureRecognizerForTint.view as! UIImageView
        
        imageDetailScrollView.isHidden = true
        tintImageView.isHidden = true
    }
    @IBAction func onFeedbackButtonPressed(_ sender: Any) {
        feedbackButtonPressed = true
        mapButtonPressed = false
        performSegue(withIdentifier: "detailsToFeedbackSegue", sender: nil)
        
    }
    
    
    
    
    
}
