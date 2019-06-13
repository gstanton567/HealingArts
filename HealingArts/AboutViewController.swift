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
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.ChihulyCG.Red.UNMC
        
        //titleLabel prettiness thing additions, idk
        titleLabel.text = "About the Healing Arts Program"
        titleLabel.textColor = UIColor.white
        titleLabel.layer.masksToBounds = true
        
        titleLabel.layer.borderWidth = 3
        titleLabel.layer.borderColor = UIColor.ChihulyCG.Red.UNMC
        titleLabel.layer.backgroundColor = UIColor.ChihulyCG.Red.UNMC
        
        
        //infoTextView prettiness thing additions, idk
        infoTextView.layer.masksToBounds = true
//        infoTextView.layer.cornerRadius = 15
//        infoTextView.layer.borderWidth = 3
//        infoTextView.layer.borderColor = UIColor.ChihulyCG.Red.UNMC
        
        //infoButton prettiness thing additions, idk
        infoButton.layer.masksToBounds = true
        infoButton.layer.cornerRadius = 15
        infoButton.layer.borderWidth = 3
        infoButton.setTitle("More Info", for: .normal)
        infoButton.setTitleColor(UIColor.white, for: .normal)
        infoButton.layer.borderColor = UIColor.ChihulyCG.Red.UNMC
        infoButton.backgroundColor = UIColor.ChihulyUI.Red.UNMC
        
        //imageView prettiness aesthetics I guess, idk
        aboutPageInfoImageView.image = UIImage(named: "CancerCenter")

        aboutPageInfoImageView.layer.borderWidth = 3
        aboutPageInfoImageView.layer.borderColor = UIColor.ChihulyCG.Red.UNMC
        aboutPageInfoImageView.backgroundColor = UIColor.ChihulyUI.Red.UNMC
        
    }
    
    
        
    @IBAction func onInfoButtonPressed(_ sender: UIButton) {
        if let link = URL(string: linkString) {
            let sfvc = SFSafariViewController(url: link)
            sfvc.delegate = (self as! SFSafariViewControllerDelegate)
            sfvc.preferredControlTintColor = .white
            sfvc.preferredBarTintColor = UIColor.ChihulyUI.Red.UNMCSafariBackground
            
            present(sfvc, animated: true)
            
        }
        
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
    
}


