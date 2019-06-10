//
//  Firebase.swift
//  HealingArts
//
//  Created by Carly Cameron on 6/10/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import Firebase
import FirebaseFirestore
import FirebaseStorage


class Firebase {
    
    
    // Add a new document with a generated ID
    //    class func addDataGeneratedID() {
    //        let database = Firestore.firestore()
    //
    //        var ref: DocumentReference? = nil
    //        ref = database.collection("Artwork").addDocument(data: [
    //            "title": "Azure and Jade Persian Ceiling",
    //            "artist": "Dale Chihuly",
    //            "date": 2017,
    //            "dimensions": "2 x 8 1/2 x 16 1/2'",
    //            "textDescription": "Chihuly began the Persian series in 1986....",
    //            "image": "",
    //            "floor": 4,
    //            "medium": "Glass",
    //            "location": ""
    //        ]) { err in
    //            if let err = err {
    //                print("Error adding document: \(err)")
    //            } else {
    //                print("Document added with ID: \(ref!.documentID)")
    //            }
    //        }
    //    }
    
    // Add a new document in collection "Artwork" with specified ID
    //    class func addDataSpecificID() {
    //        let database = Firestore.firestore()
    //        database.collection("Artwork").document("piece9").setData([
    //            "title": "Sapphire Icicle Tower",
    //            "artist": "Dale Chihuly",
    //            "date": 2017,
    //            "dimensions": "11 x 9 x 9'",
    //            "textDescription": "The initial phase of extensive experimentation with the Chandeliers culminated in the Chihuly Over Venice project (1995-1996), during which Chihuly varied both the shapes of the glass forms and the armatures themselves. Subsequent projects contined to challenge the artist to create large sculptures for spaces without ceilings or where the ceilings could not bear the weight of Chandeliers, giving life to the development of the Tower series.\nThe Sapphire Icicle Tower, which stands at eleven feet, exemplifies Chihuly's desire to mass color on a steel armature for dramatic efffect. Its approximately 325 pieces create what he calls a core of color.",
    //            "image": "",
    //            "floor": 4,
    //            "medium": "Glass",
    //            "location": ""
    //        ]) { err in
    //            if let err = err {
    //                print("Error writing document: \(err)")
    //            } else {
    //                print("Document successfully written!")
    //            }
    //        }
    //    }
    
    class func getDocumentByName(docName: String, docField: String, completion: @escaping (String, Error?) -> Void) {
        let database = Firestore.firestore()
        let docRef = database.collection("Artwork").document(docName)
        var fieldData = ""
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                if docField == "image" {
                    let arr: [String] = document.get("image") as! [String]
                    let storage = Storage.storage()
                    let gsReference = storage.reference(forURL: arr.first!)
                    gsReference.downloadURL(completion: { (url, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            fieldData = "\(url)"
                        }
                    })
                } else {
                    fieldData = document["\(docField)"] as! String
                }
                completion(fieldData, nil)
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
    }
    
    class func getAllDocumentsInCollection() -> [Artwork] {
        let database = Firestore.firestore()
        var artworks = [Artwork]()
        database.collection("Artwork").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    
                    let newArtwork = Artwork(title: data["title"] as! String, artist: (data["artist"] as? String)!, dimensions: data["dimensions"] as? String, date: "", floor: data["floor"] as? Int, textDescription: data["textDescription"] as? String, medium: data["medium"] as? String, location: data["location"] as? String, imageURLs: data["images"] as? [String])
                    artworks.append(newArtwork)
                    print("Artwork: \(newArtwork.title!)")
//                    print("Document: \(document.documentID) => \(document.data())")
                    
                }
            }
        }
        return artworks
    }
}

