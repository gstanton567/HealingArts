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
    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Thoughts And Feedback"
        
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.ChihulyCG.Gray.Graphite
        textView.layer.borderWidth = 1
        nameTextField.layer.borderColor = UIColor.ChihulyCG.Gray.Graphite
        nameTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.ChihulyCG.Gray.Graphite
        emailTextField.layer.borderWidth = 1
    }
    
    @IBAction func onSubmitPressed(_ sender: UIButton) {
        let databaseRef  = Firestore.firestore()
        
        //Text fields cannot be blank or nil
        if nameTextField.text != nil && emailTextField.text != nil && textView.text != nil && nameTextField.text != "" && emailTextField.text != "" && textView.text != "" {
            var ref = databaseRef.collection("Feedback").addDocument(data: ["name" : nameTextField.text, "email" : emailTextField.text, "comment" : textView.text]) {err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    let alertController = UIAlertController(title: "Thank You!", message: "We have received your feedback", preferredStyle: .alert)
                    let okay = UIAlertAction(title: "Okay", style: .default, handler: { (UIAlertAction) in
                        self.nameTextField.text = ""
                        self.emailTextField.text = ""
                        self.textView.text = ""
                    })
                    alertController.addAction(okay)
                    self.present(alertController, animated: true)
                }
            }
        }
        else {
            let alertController = UIAlertController(title: "Error", message: "Please fill in the text fields before submitting", preferredStyle: .alert)
            let okay = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okay)
            present(alertController, animated: true)
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

}
