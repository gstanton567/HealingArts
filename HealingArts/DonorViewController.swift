//
//  DonorViewController.swift
//  HealingArts
//
//  Created by Gwyneth Semanisin on 6/7/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit

class DonorViewController: UIViewController {

    @IBOutlet weak var donorsTextView: UITextView!
    
    //  Healing Arts Program donors
    let donors = ["Pamela and Fred Buffett","Suzanne & Walter Scott", "Warren Buffett", "Sir Chuck E Cheese", "The Hamburgler"]
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thankYouList = donors.joined(separator: "\n")
        
        //all donors will be printed on a new line within the textView
        donorsTextView.text = thankYouList
    }
    

}
