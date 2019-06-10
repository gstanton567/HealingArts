//
//  ViewController.swift
//  HealingArts
//
//  Created by Brady Fehr on 6/7/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {    
   
    var test = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        FirebaseTestViewController.getDocumentByName(docName: "piece1") { (name, error) in
//            print("YO: \(name)")
//        }
        Firebase.getAllDocumentsInCollection()
//        Firebase.getDocumentByName(docName: "piece4", docField: "title") { (name, error) in
//            print("YO: \(name)")
//            self.test = name
//            print(self.test)
//        }
//        print("test: \(self.test)")
//            let x = Artwork()
//            print("called artwork class to get property \(x.title)")
        
        
        
        
        
    }

}

