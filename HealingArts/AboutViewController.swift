//
//  AboutViewController.swift
//  HealingArts
//
//  Created by Patrick Stacey-Vargus on 6/10/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//


import UIKit
import SafariServices


class AboutViewController: UIViewController, SFSafariViewControllerDelegate {
    
    let linkString = "https://www.nebraskamed.com/healingarts"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var aboutPageInfoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 42
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.ChihulyCG.Purple.Stormcloud
        
        //titleLabel prettiness thing additions, idk
        titleLabel.text = "About the Healing Arts Program"
        titleLabel.textColor = UIColor.ChihulyUI.Red.Cherry
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = 15
        titleLabel.layer.borderWidth = 3
        titleLabel.layer.borderColor = UIColor.ChihulyCG.Red.Cherry
        titleLabel.backgroundColor = UIColor.ChihulyUI.Blue.Aqua
        
        //infoTextView prettiness thing additions, idk
        infoTextView.layer.masksToBounds = true
        infoTextView.layer.cornerRadius = 15
        infoTextView.layer.borderWidth = 3
        infoTextView.layer.borderColor = UIColor.ChihulyCG.Green.Tropical
        infoTextView.backgroundColor = UIColor.ChihulyUI.Blue.Aqua
        
        //infoButton prettiness thing additions, idk
        infoButton.layer.masksToBounds = true
        infoButton.layer.cornerRadius = 15
        infoButton.layer.borderWidth = 3
        infoButton.setTitle("More Info", for: .normal)
        infoButton.setTitleColor(UIColor.ChihulyUI.Purple.Midnight, for: .normal)
        infoButton.layer.borderColor = UIColor.ChihulyCG.Green.Tropical
        infoButton.backgroundColor = UIColor.ChihulyUI.Blue.Aqua
        
        //imageView prettiness aesthetics I guess, idk
        aboutPageInfoImageView.image = UIImage(named: "CancerCenter")
        aboutPageInfoImageView.layer.masksToBounds = true
        aboutPageInfoImageView.layer.cornerRadius = 15
        aboutPageInfoImageView.layer.borderWidth = 3
        aboutPageInfoImageView.backgroundColor = UIColor.ChihulyUI.Blue.Aqua
        aboutPageInfoImageView.layer.borderColor = UIColor.ChihulyCG.Green.Tropical
        
    }
    
    
        
    @IBAction func onInfoButtonPressed(_ sender: UIButton) {
        if let link = URL(string: linkString) {
            let sfvc = SFSafariViewController(url: link)
            sfvc.delegate = (self as! SFSafariViewControllerDelegate)
            
            present(sfvc, animated: true)
            
        }
        
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
    
}


