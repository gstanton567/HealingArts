//
//  ArtistDetailViewController.swift
//  HealingArts
//
//  Created by Gwyneth Semanisin on 6/10/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit

class ArtistDetailViewController: UIViewController {
    
    var artwork: Artwork?
    var indexOfArtist : Int!

    @IBOutlet weak var artistLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        artistLabel.text = artwork!.artist
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
