//
//  ArtDetailsViewController.swift
//  HealingArts
//
//  Created by Gwyneth Semanisin on 6/10/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit

class ArtDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var artistButton: UIButton!
    @IBOutlet weak var pieceNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mediumLabel: UILabel!
    @IBOutlet weak var dimensionsLabel: UILabel!
    
    let artist = "Dale Chihuly"
    let name = "Orange and Yellow Hornet and Rising Sun Sconce Wall"
    let date = "2017-18"
    let medium = "Blown-glass"
    let dimensions = "2 x 8 1/2 x 16.5"
    let url = "https://s3.amazonaws.com/cdn.seattlemonorail.com/wp-content/uploads/2012/05/17003603/Chihuly03.jpg"
    let artDescription = "Chihuly's Sconces are wall installations composed of blown-glass elements that are created in responce to a specfic environment. The exterior-lit sculptures are influenced by the chandeliers of the grand homes and palaces throughout Europe from which Chihuly derived inspiration. Chihuly's blown-glass forms vary in color and form and frequently reference the natural world. In Chihuly's Orange and Yellow Hornet Sconce, the elements are referred to as 'hornets' due to their elongated shape, reminiscent of the insect's spiral rear section.\nAround the exterior of the Reflection Room, carefully arranged to complement the Orange and Yellow Hornet Sconce, is the Rising Sun Sconce Wall, composed of eight Sconces. Named for things found in nature, its elements include hornets, feathers, balls, and split leaves."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let picURL = URL(string: url)
        let session = URLSession.shared
        let task = session.dataTask(with: picURL!) { (data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                self.imageView!.image = UIImage(data: data!)
            }
        }
        task.resume()
        
        artistButton.setTitle(artist, for: .normal)
        pieceNameLabel.text = name
        dateLabel.text = date
        mediumLabel.text = medium
        dimensionsLabel.text = dimensions
        descriptionTextView.text = artDescription
        
    }
    
    
    
    
    
    // MARK: - Navigation
    
    
    //Artist info segue
    @IBAction func onArtistButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "detailsToArtistDetailsSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let avc = segue.destination as! ArtistDetailViewController
        
    }
    
    
    //single piece map
    @IBAction func onMapButtonPressed(_ sender: UIButton) {
    }
    
    
    
}
