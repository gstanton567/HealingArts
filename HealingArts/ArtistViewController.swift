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
    var selectedArtist : Artist?
    var indexOfArtist = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Artists"
//gets data
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewWillAppear(true)
       
    }
    
//table view functions
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Firebase.globalArtists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        let artist = Firebase.globalArtists[indexPath.row]
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
        selectedArtist = Firebase.globalArtists[indexPath.row]
        performSegue(withIdentifier: "toArtistDetail", sender: nil)
    }
    
//prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as? ArtistDetailViewController
        dvc!.artist = selectedArtist
    }
    
    

}
