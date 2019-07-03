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
    var artists : [Artist] = []
    var selectedArtist : Artist?
    var indexOfArtist = 0
    var images = ["chihulypic", "harnoor", "dan", "gold", "kaneko"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Artists"
//gets data
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewWillAppear(true)
        Firebase.getArtists(completion: { (artists, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                self.artists = artists
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
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
        cell?.textLabel!.text = artist.name
        cell?.imageView?.image = artist.images.first
        return cell!
    }
    
//delete lines when cells are empty
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArtist = artists[indexPath.row]
        performSegue(withIdentifier: "toArtistDetail", sender: nil)
    }
    
//prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as? ArtistDetailViewController
        dvc!.artist = selectedArtist
    }
    
    

}
