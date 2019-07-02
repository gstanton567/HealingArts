//
//  CalendarViewController.swift
//  HealingArts
//
//  Created by Grayson Stanton on 7/1/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var events = [Event]()
    var dans = [UIImage(named: "CancerCenter"), UIImage(named: "CancerCenter")]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("Grayson was here")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return events.count
        return dans.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CalendarCollectionViewCell
//        let event = events[indexPath.row]
        cell.imageView.image = dans.first as! UIImage
//        cell.textlabel.text = "\(event.title) on \(event.date)"
        return cell
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
