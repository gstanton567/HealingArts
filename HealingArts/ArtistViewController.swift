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
    //var artistName : [Artist] = []
    //var artistImage : [Artist] = []
//    var images = ["chihulypic", "harnoor", "dan", "gold", "kaneko"]
    
    var artworks: [Artwork] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Firebase.getAllDocumentsInCollection { (artworks, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                self.artworks = artworks
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
        return artworks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        let artwork = artworks[indexPath.row]
//        cell?.imageView!.image = UIImage(named: pictures)
//        cell?.textLabel?.text = "artist"
        cell?.imageView?.image = artwork.images.first
        cell?.textLabel?.text = artwork.title
        return cell!
    }

}
