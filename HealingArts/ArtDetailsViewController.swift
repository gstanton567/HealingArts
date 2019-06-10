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
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var pieceNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mediumLabel: UILabel!
    
    let artist = "chihuly"
    let name = "glass"
    let date = "6/00/1999"
    let medium = "glass on glass"
    let url = "https://s3.amazonaws.com/cdn.seattlemonorail.com/wp-content/uploads/2012/05/17003603/Chihuly03.jpg"
    let artDescription = "this is a test. blahblahblahblahlblahblahblah\ndjfl;asjf;las"
    
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
        
        artistLabel.text = artist
        pieceNameLabel.text = name
        dateLabel.text = date
        mediumLabel.text = medium
        descriptionTextView.text = artDescription
        
    }
    
    
    
    
    
    // MARK: - Navigation
    
    @IBAction func onMoreButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "detailsToArtistDetailsSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let avc = segue.destination as! ArtistDetailViewController
        
    }
    
    
}
