//
//  AboutViewController.swift
//  HealingArts
//
//  Created by Patrick Stacey-Vargus on 6/10/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//


import UIKit
import SafariServices
import AVKit
//This page was an old version of the about page and is no longer used

class AboutViewController: UIViewController, SFSafariViewControllerDelegate {
    
    let linkString = "https://www.nebraskamed.com/healingarts"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var aboutPageInfoImageView: UIImageView!
    @IBOutlet weak var artistsWordsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        view.backgroundColor = UIColor.ChihulyUI.Red.UNMC
//
//        view.layer.masksToBounds = true
//        view.layer.borderWidth = 3
//        view.layer.borderColor = UIColor.ChihulyCG.Red.UNMC
//
//        //titleLabel prettiness thing additions, idk
//        titleLabel.text = "About the Healing Arts Program"
//        titleLabel.textColor = UIColor.white
//        titleLabel.layer.masksToBounds = true
//
//        titleLabel.layer.borderWidth = 3
//        titleLabel.layer.borderColor = UIColor.white.cgColor
//        titleLabel.layer.backgroundColor = UIColor.ChihulyCG.Red.UNMC
//
//
//        //infoTextView prettiness thing additions, idk
//        infoTextView.layer.masksToBounds = true
//        infoTextView.textColor = UIColor.white
//
//
//        //infoButton prettiness thing additions, idk
//        infoButton.layer.masksToBounds = true
//        infoButton.layer.cornerRadius = 15
//        infoButton.layer.borderWidth = 3
//        infoButton.setTitle("More Info", for: .normal)
//        infoButton.setTitleColor(UIColor.white, for: .normal)
//        infoButton.layer.borderColor = UIColor.white.cgColor
//        infoButton.backgroundColor = UIColor.ChihulyUI.Red.FlowerEdgeRed
//
//        //words from artists button
//        artistsWordsButton.layer.masksToBounds = true
//        artistsWordsButton.layer.cornerRadius = 15
//        artistsWordsButton.layer.borderWidth = 3
//        artistsWordsButton.layer.borderColor = UIColor.white.cgColor
//        artistsWordsButton.backgroundColor = UIColor.ChihulyUI.Red.FlowerEdgeRed
//        artistsWordsButton.setTitleColor(UIColor.white, for: .normal)
//
//        //imageView prettiness aesthetics I guess, idk
//        aboutPageInfoImageView.image = UIImage(named: "CancerCenter")
//
//        aboutPageInfoImageView.layer.borderWidth = 3
//        aboutPageInfoImageView.layer.borderColor = UIColor.white.cgColor
//        aboutPageInfoImageView.backgroundColor = UIColor.ChihulyUI.Red.UNMCSafariBackground
        
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        infoTextView.setContentOffset(CGPoint.zero, animated: false)
//    }
//
//    @IBAction func artistWordsButtonIsPressed(_ sender: UIButton) {
//        if let path = Bundle.main.path(forResource: "thevideo", ofType: "mp4"){
//            let video = AVPlayer(url: URL(fileURLWithPath: path))
//            let videoPlayer = AVPlayerViewController()
//            videoPlayer.player = video
//            present(videoPlayer, animated: true, completion:{
//                video.play()
//            })
//        }
//    }
//
//
//
//    @IBAction func onInfoButtonPressed(_ sender: UIButton) {
//        if let link = URL(string: linkString) {
//            let sfvc = SFSafariViewController(url: link)
//            sfvc.delegate = (self as! SFSafariViewControllerDelegate)
//            sfvc.preferredControlTintColor = .white
//            sfvc.preferredBarTintColor = UIColor.ChihulyUI.Red.UNMCSafariBackground
//
//            present(sfvc, animated: true)
//
//        }
//
//    }
//
//    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
//        dismiss(animated: true)
//    }
//
}


