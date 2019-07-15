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
    
    var donorPictures: [String] = ["walterscott", "fredandpam", "clwerner", "dan", "harnoor", "gold"]
    var donorNames: [String] = ["Walter Scott, Jr.", "Fred and Pamela Buffett", "C.L. Werner", "Dan Shipp", "Harnoor Singh", "Dr.Gold"]
    
    var scrollingTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did Load")
        
        donateAskLabel.text = "By giving a small donation, you can help support those battling cancer and a program that brings them peace of mind.\n\nYou can make a difference today."
        
        startTimer()
    }
    
    // MARK: - Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return donorPictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = donorCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DonorCollectionViewCell
        cell.donorImageView.image = UIImage(named: donorPictures[indexPath.item])
        cell.donorNameLabel.text = donorNames[indexPath.item]
        
        return cell
    }
    
    
    //  MARK:  Auto-Scrolling
    /**
     Invokes Timer to start Automatic Animation with repeat enabled
     */
    func startTimer() {
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: Selector("scrollToNextCell"), userInfo: nil, repeats: true);
    }
    
    @objc func scrollToNextCell(){
        
        //get cell size
        let cellSize = CGSize(width: self.view.frame.width, height: self.view.frame.height);
        
        //get current content Offset of the Collection view
        let contentOffset = donorCollectionView.contentOffset;
        
        if donorCollectionView.contentSize.width <= donorCollectionView.contentOffset.x + cellSize.width
        {
            donorCollectionView.scrollRectToVisible(CGRect(x: 0, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true);
            
        } else {
            donorCollectionView.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width + 9.2499, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true);
            
        }
        
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
        
    }
    
}
