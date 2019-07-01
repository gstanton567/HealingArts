//
//  TestAboutViewController.swift
//  HealingArts
//
//  Created by Carly Cameron on 6/28/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit

class TestAboutViewController: UIViewController {

    @IBOutlet weak var redBehindImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did Load")

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIImageView {
    
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
        
//        self.layer.borderWidth = 2
        
        //self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
}
