//
//  CalendarViewController.swift
//  HealingArts
//
//  Created by Carly Cameron on 7/5/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  
    var events = [""]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as! CalendarTableViewCell
        cell.eventImageView.image = UIImage(named: "dan")
        cell.eventTitleLabel.text = "Event title"
        cell.locationLabel.text = "mav landing"
        cell.dateLabel.text = "january"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.rowHeight = 150
        return 150
    }

}
