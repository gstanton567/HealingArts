//
//  ArtistDetailViewController.swift
//  HealingArts
//
//  Created by Gwyneth Semanisin on 6/10/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit

class ArtistDetailViewController: UIViewController {
    
    var artworkPiece: Artwork?
    var indexOfArtist : Int!
    var artist : Artist?

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var viewCollectionButton: UIButton!
    @IBOutlet weak var artistImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artistLabel.text = artist?.name
        textView.text = artist?.textDesc
        artistImageView.image = artist!.images.first
//        if artworkPiece?.artist == nil {
//           viewCollectionButton.isEnabled = false
//        }
    }
    
    
//prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as? CollectionViewController
        let artistName = artist?.name
        dvc!.artistName = artistName
    }
 

}
