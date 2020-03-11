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
    
    @IBOutlet weak var aboutDescriptionLabel: UILabel!
    @IBOutlet weak var redBehindImage: UIImageView!
    @IBOutlet weak var donateAskLabel: UILabel!
    @IBOutlet weak var donorCollectionView: UICollectionView!
    
    var donorPictures: [String] = []
    var donorNames: [String] = ["Mr. & Mrs. Walter Scott, Jr.", "Marshall & Mona Faith", "Dr. C. C. & Mabel L. Criss Memorial Foundation", "Mr. Michael & Dr. Gail Walling Yanney", "Amy L. Scott", "Bill & Lisa Roskens", "Robert E. Owen", "Robert & Mary Harbour", "Mary Whyte", "Carol Gendler", "Stanley Winokur", "Jeanne and Larry Williams", "Roger & Kathleen Weitz", "Richard and Laura Schrager", "Samuel Poppleton", "Mr. & Mrs. William L. Otis", "John W. Hilton, M.D.", "Jenard and Gail Gross", "Adam and Sarah Yale", "Margaret A. Lloyd, M.D.", "James Luyten and Meredith Fuller", "Mogens & Cynthia Bay", "Opera Omaha", "Guy and Wanda Bush", "Senator E. Benjamin & Diane Nelson", "Todd Cuddy", "Rita M. Henry, Ph.D.", "Dr. & Mrs. Martin A. Massengale", "Michele Jeffres", "Lois Cudley", "HI Omaha, LLC DBA Home Instead Senior Care 100", "Mr. James T. and Mrs. Dian J. Warren", "Fred and Joy Witecy", "Col. (Ret) & Mrs. John A. O'Donovan", "Robert and Robyn Freeman", "Abdul Latasha Muhammad", "Amy and Tony Volk", "Mr. Christopher B. Kelly and Dr. Rosemary L. Edzie", "Marshall Borchert", "Thelma Wiser", "Valerie Patzloff-Duntz", "Leon Espinoza", "Jeff Wiser", "Lisa Eastman", "Rebecca Wiser", "Joseph and Kristine Gardner", "Pam Grudle", "Joyce Pitman", "Rachel Cordova"]
    
    var scrollingTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("View did Load")
        
        donateAskLabel.text = "By giving a small donation, you can help support those battling cancer and a program that brings them peace of mind.\n\nYou can make a difference today."
        aboutDescriptionLabel.text = "The Healing Arts program's vision is to engage patients, caregivers, staff and students to heal through art.\nThe Healing Arts Program’s mission is to:\n- Educate and build community awareness encompassing the arts, health and medicine\n- Provide visual, performing and therapeutic arts experiences\n- Create an environment promoting healing and humanizing the hospital experience\n- Integrate and enhance our evidence-based experiences within UNMC/Nebraska Medicine through the arts"
        //sets text for different paragraphs on the about page
        
        startTimer()
    }
    
    // MARK: - Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return donorNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = donorCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DonorCollectionViewCell
        //cell.donorImageView.image = UIImage(named: donorPictures[indexPath.item])
        cell.donorNameLabel.text = donorNames[indexPath.item]
        
        return cell
    }
    
    
    //  MARK:  Auto-Scrolling
    /**
     Invokes Timer to start Automatic Animation with repeat enabled
     */
    func startTimer() {
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: Selector("scrollToNextCell"), userInfo: nil, repeats: true)
    }
    
    @objc func scrollToNextCell(){
        
        //get cell size
        let cellSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        
        //get current content Offset of the Collection view
        let contentOffset = donorCollectionView.contentOffset
        
        if donorCollectionView.contentSize.width <= donorCollectionView.contentOffset.x + cellSize.width
        {
            donorCollectionView.scrollRectToVisible(CGRect(x: 0, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
            
        } else {
            donorCollectionView.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width + 9.7, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
            
        }
        
    }
    
     // MARK: - Buttons
     
 //plays video when button is clicked
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
    
    //links user to Docent lead tours when button is pressed
    @IBAction func onTourButtonPressed(_ sender: UIButton) {
        let linkString = "https://www.eventbrite.com/e/healing-arts-tour-tickets-35186263060"
        if let link = URL(string: linkString) {
            let sfvc = SFSafariViewController(url: link)
            sfvc.delegate = (self as! SFSafariViewControllerDelegate)
            
            present(sfvc, animated: true)
        }
        
    }
    
    //links user to donation website when button is pressed

    @IBAction func onGiveButtonPressed(_ sender: UIButton) {
        let linkString = "https://nufoundation.org/-/unmc-fred-and-pamela-buffett-cancer-center-fred-and-pamela-buffett-cancer-center-healing-arts-program-fund-01133070"
        if let link = URL(string: linkString) {
            let sfvc = SFSafariViewController(url: link)
            sfvc.delegate = (self as! SFSafariViewControllerDelegate)
            
            present(sfvc, animated: true)
        }
    }
    
    //links user to UNMC webpage when button is pressed

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
//rounds an image
extension UIImageView {
    
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
        
    }
    
}
