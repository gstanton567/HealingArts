//
//  MapDetailViewController.swift
//  HealingArts
//
//  Created by Keegan Brown on 6/7/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit

class MapDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        performSegue(withIdentifier: "unwindToMapSegue", sender: nil)
    }

}
