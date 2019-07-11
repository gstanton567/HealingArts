//
//  TestAboutViewController.swift
//  HealingArts
//
//  Created by Carly Cameron on 6/28/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit
import SafariServices
import AVKit

class TestAboutViewController: UIViewController, SFSafariViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var redBehindImage: UIImageView!
    @IBOutlet weak var donateAskLabel: UILabel!
    @IBOutlet weak var donorCollectionView: UICollectionView!
    
    var donorPictures: [String] = ["walterscott", "fredandpam", "clwerner", "dan", "harnoor"]
    var donorNames: [String] = ["Walter Scott, Jr.", "Fred and Pamela Buffett", "C.L. Werner", "Dan Shipp", "Harnoor Singh"]
    
    var scrollingTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did Load")
        
        donateAskLabel.text = "By giving a small donation, you can help support those battling cancer and a program that brings them peace of mind.\n\nYou can make a difference today."
    }
    
    // MARK: - Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return donorPictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = donorCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DonorCollectionViewCell
        cell.donorImageView.image = UIImage(named: donorPictures[indexPath.item])
        cell.donorNameLabel.text = donorNames[indexPath.item]
        
        
        
        var rowIndex = indexPath.row
        let numberOfRecords: Int = donorPictures.count - 1
        print(rowIndex)
        if rowIndex < numberOfRecords{
            rowIndex = rowIndex + 1
        } else{
            rowIndex = 0
        }
        
        scrollingTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(TestAboutViewController.startTimer(theTimer:)), userInfo: rowIndex, repeats: true)
        
        return cell
    }
    
    @objc func startTimer(theTimer: Timer){
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.donorCollectionView.scrollToItem(at: IndexPath(row: theTimer.userInfo as! Int, section: 0), at: .left, animated: false)
        }, completion: nil)
        
        
    }
    
    
    
     // MARK: - Buttons
     
 
    @IBAction func videoButton(_ sender: Any) {
        if let path = Bundle.main.path(forResource: "thevideo", ofType: "mp4"){
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            present(videoPlayer, animated: true, completion:{
                video.play()
            })
        }
        
    }
    
    
    @IBAction func onTourButtonPressed(_ sender: UIButton) {
        let linkString = "https://www.eventbrite.com/e/healing-arts-tour-tickets-35186263060"
        if let link = URL(string: linkString) {
            let sfvc = SFSafariViewController(url: link)
            sfvc.delegate = (self as! SFSafariViewControllerDelegate)
            
            present(sfvc, animated: true)
        }
        
    }
    
    @IBAction func onGiveButtonPressed(_ sender: UIButton) {
        let linkString = "https://nufoundation.org/-/unmc-fred-and-pamela-buffett-cancer-center-fred-and-pamela-buffett-cancer-center-healing-arts-program-fund-01133070"
        if let link = URL(string: linkString) {
            let sfvc = SFSafariViewController(url: link)
            sfvc.delegate = (self as! SFSafariViewControllerDelegate)
            
            present(sfvc, animated: true)
        }
    }
    
    @IBAction func onButtonPressed(_ sender: Any) {
        
        let linkString = "https://www.nebraskamed.com/healingarts"
        if let link = URL(string: linkString) {
            let sfvc = SFSafariViewController(url: link)
            sfvc.delegate = (self as! SFSafariViewControllerDelegate)
            //            sfvc.preferredControlTintColor = .white
            //            sfvc.preferredBarTintColor = UIColor.ChihulyUI.Red.UNMCSafariBackground
            
            present(sfvc, animated: true)
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        //dismiss(animated: true)
    }
    
    
}

extension UIImageView {
    
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
        
        //        self.layer.borderWidth = 2
        
        //self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
}
