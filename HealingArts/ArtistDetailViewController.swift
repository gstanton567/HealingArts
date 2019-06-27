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

    @IBOutlet weak var artistLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        artistLabel.text = artworkPiece!.artist
    }
    

    
//prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as? CollectionViewController
        let artistName = self.artworkPiece!.artist
        dvc!.artistName = artistName
    }
 

}
