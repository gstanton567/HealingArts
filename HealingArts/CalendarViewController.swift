//
//  CalendarViewController.swift
//  HealingArts
//
//  Created by Carly Cameron on 7/5/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  
    @IBOutlet weak var tableView: UITableView!
    var events = [""]

    override func viewDidLoad() {
        super.viewDidLoad()

        // I don't know how to set the title at the top of the view controller becuase this is not working
        self.title = "Upcoming Events"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        Firebase.getEvents { (events, err) in
            if let err = err {
                print("ERRRORRRRR \(err.localizedDescription)")
            } else {
                print("good")
                DispatchQueue.main.async {
                    Firebase.globalEvents = events
                    //                    Firebase.globalEvents[0].getImageURL(summary: events.first!.summary!)
                    self.tableView.reloadData()
                }
                print("Oooga 3ga")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Firebase.globalEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as! CalendarTableViewCell
        cell.eventImageView.image = Firebase.globalEvents[indexPath.row].image
        cell.eventTitleLabel.text = Firebase.globalEvents[indexPath.row].title
        cell.locationLabel.text = Firebase.globalEvents[indexPath.row].location
        cell.dateLabel.text = Firebase.globalEvents[indexPath.row].date

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.rowHeight = 150
        return 150
    }
    
}
