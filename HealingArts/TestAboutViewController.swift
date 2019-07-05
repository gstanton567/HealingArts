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

class TestAboutViewController: UIViewController, SFSafariViewControllerDelegate {

    @IBOutlet weak var redBehindImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did Load")

        // Do any additional setup after loading the view.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
    
}

extension UIImageView {
    
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
        
//        self.layer.borderWidth = 2
        
        //self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
}
