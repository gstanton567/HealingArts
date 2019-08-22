//
//  FeedbackViewController.swift
//  HealingArts
//
//  Created by Brady Fehr on 6/13/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class FeedbackViewController: UIViewController {
    
    //    @IBOutlet weak var starOneImageView: UIImageView!
    //    @IBOutlet weak var starTwoImageView: UIImageView!
    //    @IBOutlet weak var starThreeImageView: UIImageView!
    //    @IBOutlet weak var starFourImageView: UIImageView!
    //    @IBOutlet weak var starFiveImageView: UIImageView!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var interestingLabel: UILabel!
    @IBOutlet weak var qualityLabel: UILabel!
    @IBOutlet weak var rateSlider: UISlider!
    @IBOutlet weak var qualitySlider: UISlider!
    @IBOutlet weak var interestingSlider: UISlider!
    
    //    @IBOutlet var nameTextField: UITextField!
    //
    //    @IBOutlet var emailTextField: UITextField!
    
    
    @IBOutlet var textView: UITextView!
    
    var artTitle: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Thoughts And Feedback"
        
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.ChihulyCG.Gray.Graphite
        textView.layer.borderWidth = 1
        
       
    }
    
    @IBAction func rateSliderAction(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        rateLabel.text = "\(currentValue)"
    }
    
    @IBAction func qualitySliderAction(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        qualityLabel.text = "\(currentValue)"
    }
    
    @IBAction func interestingSliderAction(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        interestingLabel.text = "\(currentValue)"
    }
   
    
    @IBAction func onSubmitPressed(_ sender: UIButton) {
        
        let feedback = "\(rateLabel.text!)&&\(qualityLabel.text!)&&\(interestingLabel.text!)&&\(textView.text!)"
        
        let timeStamp = NSDate().timeIntervalSince1970

        Firebase.sendFeedback(title: artTitle!, timestamp: timeStamp, feedback: feedback) { (success) in
            if success {
                let alertController = UIAlertController(title: "Thank You!", message: "We have received your feedback", preferredStyle: .alert)
                let okay = UIAlertAction(title: "Okay", style: .default, handler: { (UIAlertAction) in
                    //reset
                    self.textView.text = ""
                    self.rateSlider.value = 5
                    self.qualitySlider.value = 5
                    self.interestingSlider.value = 5
                    self.rateLabel.text = "5"
                    self.qualityLabel.text = "5"
                    self.interestingLabel.text = "5"
                })
                alertController.addAction(okay)
                self.present(alertController, animated: true)
            } else {
                let alertController = UIAlertController(title: "Try Again", message: "We have not received your feedback", preferredStyle: .alert)
                let okay = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alertController.addAction(okay)
                self.present(alertController, animated: true)
            }
        }
        
        //Text fields cannot be blank or nil
        //        if nameTextField.text != nil && emailTextField.text != nil && textView.text != nil && nameTextField.text != "" && emailTextField.text != "" && textView.text != "" {
        //            var ref = databaseRef.collection("Feedback").addDocument(data: ["name" : nameTextField.text, "email" : emailTextField.text, "comment" : textView.text]) {err in
        //                if let err = err {
        //                    print("Error adding document: \(err)")
        //                } else {
        
        
        
        
        
        
        
        
        //            }
        //        }
        //        else {
        //            let alertController = UIAlertController(title: "Error", message: "Please fill in the text fields before submitting", preferredStyle: .alert)
        //            let okay = UIAlertAction(title: "OK", style: .default, handler: nil)
        //            alertController.addAction(okay)
        //            present(alertController, animated: true)
    }
}




