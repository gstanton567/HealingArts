//
//  ArtistViewController.swift
//  HealingArts
//
//  Created by Justine Linscott on 6/7/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ArtistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//outlets
    @IBOutlet weak var tableView: UITableView!
    
//properties
    var artworks : [Artwork] = [Artwork]()
    var artists : [String] = [String]()
    var indexOfArtist = 0
    var images = ["chihulypic", "harnoor", "dan", "gold", "kaneko"]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Artists"
//gets data
        Firebase.getAllDocumentsInCollection { (artworks, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                self.artworks = artworks
                self.repeatArtists()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
//table view functions
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        let artist = artists[indexPath.row]
//prints to tableview cell
        cell?.textLabel!.text = artist
        return cell!
    }
    
//delete lines when cells are empty
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
//gets array of artists with no repeats
    func repeatArtists() {
        for artwork in artworks {
            if self.artists.contains(artwork.artist!) {
                print("duplicate")
            } else {
                self.artists.append(artwork.artist!)
                
            }
        }
    }
    
//prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as? ArtistDetailViewController
        indexOfArtist = tableView.indexPathForSelectedRow!.row
        let artwork = self.artworks[indexOfArtist]
        dvc!.artwork = artwork
    }
    
    

}
