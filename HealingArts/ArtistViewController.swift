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
    var images = ["chihulypic", "harnoor", "dan", "gold", "kaneko"]
    override func viewDidLoad() {
        super.viewDidLoad()

    }
//table view functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        let pictures = images[indexPath.row]
        cell?.imageView!.image = UIImage(named: pictures)
        cell?.textLabel?.text = "artist"
        return cell!
    }

}
