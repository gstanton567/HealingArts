//
//  ArtistViewController.swift
//  HealingArts
//
//  Created by Justine Linscott on 6/7/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        let pictures = images[indexPath.row]
        cell?.imageView!.image = UIImage(named: pictures)
        cell?.imageView?.contentMode = .scaleAspectFit
        cell?.textLabel?.text = "artist"
        return cell!
    }

}
