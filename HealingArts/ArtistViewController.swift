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
    var images = ["chihulypic", "harnoor", "dan", "gold", "kaneko"]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Artists"
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
      //  let pictures = [artworks[indexPath.row].imageURLs]
        let name = artworks[indexPath.row].artist
      //  cell?.imageView!.image = UIImage(named: arraypic)
        cell?.textLabel?.text = name
        return cell!
    }

}
