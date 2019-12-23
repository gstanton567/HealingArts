//
//  SpinnerViewController.swift
//  HealingArts
//
//  Created by Keegan Brown on 7/5/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit

class SpinnerViewController: UIViewController {
    
    //creates loading screen with spinner
    
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    var label = UILabel(frame: CGRect(x: 138, y: 400, width: 200, height: 40))
    
    override func loadView() {
        view = UIView()
        
        label.center = self.view.center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Loading..."
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-UltraLight", size: 32.0)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        
        let stackView = UIStackView(arrangedSubviews: [label, spinner])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.backgroundColor = UIColor.ChihulyUI.Red.UNMC
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //pulls in map artworks
        Firebase.getMapArtworks { (mapArt, error) in
            if error != nil {
                print (error?.localizedDescription)
            } else {
                Firebase.globalMapArt = mapArt
            }
        }
    
        //pulls in artworks
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
