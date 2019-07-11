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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Thoughts And Feedback"
        
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.ChihulyCG.Gray.Graphite
        textView.layer.borderWidth = 1
        
        //        nameTextField.layer.borderColor = UIColor.ChihulyCG.Gray.Graphite
        //        nameTextField.layer.borderWidth = 1
        //        emailTextField.layer.borderColor = UIColor.ChihulyCG.Gray.Graphite
        //        emailTextField.layer.borderWidth = 1
        //
        //        let tapGestureRecognizerOne = UITapGestureRecognizer(target: self, action: #selector(starOneTapped(tapGestureRecognizer:)))
        //        starOneImageView.isUserInteractionEnabled = true
        //        starOneImageView.addGestureRecognizer(tapGestureRecognizerOne)
        //
        //        let tapGestureRecognizerTwo = UITapGestureRecognizer(target: self, action: #selector(starTwoTapped(tapGestureRecognizer:)))
        //        starTwoImageView.isUserInteractionEnabled = true
        //        starTwoImageView.addGestureRecognizer(tapGestureRecognizerTwo)
        //
        //        let tapGestureRecognizerThree = UITapGestureRecognizer(target: self, action: #selector(starThreeTapped(tapGestureRecognizer:)))
        //        starThreeImageView.isUserInteractionEnabled = true
        //        starThreeImageView.addGestureRecognizer(tapGestureRecognizerThree)
        //
        //        let tapGestureRecognizerFour = UITapGestureRecognizer(target: self, action: #selector(starFourTapped(tapGestureRecognizer:)))
        //        starFourImageView.isUserInteractionEnabled = true
        //        starFourImageView.addGestureRecognizer(tapGestureRecognizerFour)
        //
        //        let tapGestureRecognizerFive = UITapGestureRecognizer(target: self, action: #selector(starFiveTapped(tapGestureRecognizer:)))
        //        starFiveImageView.isUserInteractionEnabled = true
        //        starFiveImageView.addGestureRecognizer(tapGestureRecognizerFive)
        
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
    //    @objc func starOneTapped(tapGestureRecognizer: UITapGestureRecognizer)
    //    {
    //        starOneImageView.image = UIImage.init(named: "RedStar")
    //        starTwoImageView.image = UIImage.init(named: "RedStarHollow")
    //        starThreeImageView.image = UIImage.init(named: "RedStarHollow")
    //        starFourImageView.image = UIImage.init(named: "RedStarHollow")
    //        starFiveImageView.image = UIImage.init(named: "RedStarHollow")
    //        // Your action
    //    }
    //
    //    @objc func starTwoTapped(tapGestureRecognizer: UITapGestureRecognizer)
    //    {
    //        starOneImageView.image = UIImage.init(named: "RedStar")
    //        starTwoImageView.image = UIImage.init(named: "RedStar")
    //        starThreeImageView.image = UIImage.init(named: "RedStarHollow")
    //        starFourImageView.image = UIImage.init(named: "RedStarHollow")
    //        starFiveImageView.image = UIImage.init(named: "RedStarHollow")
    //        // Your action
    //    }
    //
    //    @objc func starThreeTapped(tapGestureRecognizer: UITapGestureRecognizer)
    //    {
    //        starOneImageView.image = UIImage.init(named: "RedStar")
    //        starTwoImageView.image = UIImage.init(named: "RedStar")
    //        starThreeImageView.image = UIImage.init(named: "RedStar")
    //        starFourImageView.image = UIImage.init(named: "RedStarHollow")
    //        starFiveImageView.image = UIImage.init(named: "RedStarHollow")
    //        // Your action
    //    }
    //
    //    @objc func starFourTapped(tapGestureRecognizer: UITapGestureRecognizer)
    //    {
    //        starOneImageView.image = UIImage.init(named: "RedStar")
    //        starTwoImageView.image = UIImage.init(named: "RedStar")
    //        starThreeImageView.image = UIImage.init(named: "RedStar")
    //        starFourImageView.image = UIImage.init(named: "RedStar")
    //        starFiveImageView.image = UIImage.init(named: "RedStarHollow")
    //        // Your action
    //    }
    //
    //    @objc func starFiveTapped(tapGestureRecognizer: UITapGestureRecognizer)
    //    {
    //        starOneImageView.image = UIImage.init(named: "RedStar")
    //        starTwoImageView.image = UIImage.init(named: "RedStar")
    //        starThreeImageView.image = UIImage.init(named: "RedStar")
    //        starFourImageView.image = UIImage.init(named: "RedStar")
    //        starFiveImageView.image = UIImage.init(named: "RedStar")
    //        // Your action
    //    }
    
    @IBAction func onSubmitPressed(_ sender: UIButton) {
        let databaseRef  = Firestore.firestore()
        
        //Text fields cannot be blank or nil
        //        if nameTextField.text != nil && emailTextField.text != nil && textView.text != nil && nameTextField.text != "" && emailTextField.text != "" && textView.text != "" {
        //            var ref = databaseRef.collection("Feedback").addDocument(data: ["name" : nameTextField.text, "email" : emailTextField.text, "comment" : textView.text]) {err in
        //                if let err = err {
        //                    print("Error adding document: \(err)")
        //                } else {
        let alertController = UIAlertController(title: "Thank You!", message: "We have received your feedback", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default, handler: { (UIAlertAction) in
            //                        self.nameTextField.text = ""
            //                        self.emailTextField.text = ""
            self.textView.text = ""
        })
        alertController.addAction(okay)
        self.present(alertController, animated: true)
        
        //            }
        //        }
        //        else {
        //            let alertController = UIAlertController(title: "Error", message: "Please fill in the text fields before submitting", preferredStyle: .alert)
        //            let okay = UIAlertAction(title: "OK", style: .default, handler: nil)
        //            alertController.addAction(okay)
        //            present(alertController, animated: true)
    }
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


