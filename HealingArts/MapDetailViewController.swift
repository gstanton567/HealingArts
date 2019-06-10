//
//  MapDetailViewController.swift
//  HealingArts
//
//  Created by Keegan Brown on 6/7/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit

class MapDetailViewController: UIViewController {
    
    @IBOutlet weak var artTitleLabel: UILabel!
    
    var artwork : ArtworkItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        artTitleLabel.text = artwork?.title
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        performSegue(withIdentifier: "unwindToMapSegue", sender: nil)
    }

}
