//
//  FirebaseTestViewController.swift
//  HealingArts
//
//  Created by Carly Cameron on 6/9/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class FirebaseTestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    
    // Add a new document with a generated ID
    func addDataGeneratedID() {
        let database = Firestore.firestore()
        
        var ref: DocumentReference? = nil
        ref = database.collection("Artwork").addDocument(data: [
            "title": "Azure and Jade Persian Ceiling",
            "artist": "Dale Chihuly",
            "date": 2017,
            "dimensions": "2 x 8 1/2 x 16 1/2'",
            "textDescription": "Chihuly began the Persian series in 1986....",
            "image": "",
            "floor": 4,
            "medium": "Glass",
            "location": ""
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    // Add a new document in collection "Artwork" with specified ID
    func addDataSpecificID() {
        let database = Firestore.firestore()
        database.collection("Artwork").document("piece2").setData([
            "title": "Azure and Jade Persian Ceiling",
            "artist": "Dale Chihuly",
            "date": 2017,
            "dimensions": "2 x 8 1/2 x 16 1/2'",
            "textDescription": "Chihuly began the Persian series in 1986....",
            "image": "",
            "floor": 4,
            "medium": "Glass",
            "location": ""
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    class func getDocumentByName(docName: String, completion: @escaping (String, Error?) -> Void) {
        let database = Firestore.firestore()
        let docRef = database.collection("Artwork").document(docName)
        var string = ""
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                //this is how you can retrieve a specific piece of data from the document
                //document.get(field: "title")
                string = document["title"] as! String
                completion(string, nil)
                print("string: \(string)")
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func getAllDocumentsInCollection() {
        let database = Firestore.firestore()
        database.collection("cities").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("Document: \(document.documentID) => \(document.data())")
                }
            }
        }
    }
}
