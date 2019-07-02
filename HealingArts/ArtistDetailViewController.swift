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

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var artistLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        artistLabel.text = artworkPiece!.artist
        textView.text = "    Dale Chihly is known for revolutionizing the studio glass movement and elevating perceptions of the glass medium. He employs a diverse array of materials to realize his creative vision through drawing, painting, and sculpture. Chihuly is renowned for his iconic glass sculptures, ambititious site-specific public installations, and exhibitions in historic cities, museums, and gardens around the world. \n     Born in 1941 in Tacoma, Washington, Chihuly draws inspiration form the Pacific Northwest region. A leader of the studio art movement, Chihuly established the glass program at the Rhode Island School of Design and cofounded the Pilchuck Glass School in Stanwood, Washington. Chihuly, who continues to create art at his studio in Seattle, has received numerous awards and honorary degrees, and his work is included in more than 200 museums collections worldwide, including the Metropolitan Museum of Art, the Smithsonian American Art Museum, and the Corning Museum of Glass"
    }
    

    
//prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as? CollectionViewController
        let artistName = self.artworkPiece!.artist
        dvc!.artistName = artistName
    }
 

}
