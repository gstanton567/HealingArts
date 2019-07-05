//
//  SpinnerViewController.swift
//  HealingArts
//
//  Created by Keegan Brown on 7/5/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit

class SpinnerViewController: UIViewController {
    
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    override func loadView() {
        view = UIView()
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.backgroundColor = UIColor.ChihulyUI.Red.UNMC
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        Firebase.getAllDocumentsInCollection { (artworks, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                Firebase.globalArtworks = artworks
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toTabBarSegue", sender: nil)
                }
            }
        }
        
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
