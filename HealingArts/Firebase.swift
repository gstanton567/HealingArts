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
    
    static var globalArtworks : [Artwork] = []
    static var globalMapArt : [Artwork] = []
    static var globalArtists : [Artist] = []
    static var globalEvents : [Event] = []
    static var globalModArtworks : [Artwork] = []
    
    //     Add a new document with a generated ID
    class func addDataGeneratedID() {
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
    
    //     Add a new document in collection "Artwork" with specified ID
    class func addDataSpecificID() {
        let database = Firestore.firestore()
        database.collection("Artwork").document("piece9").setData([
            "title": "Sapphire Icicle Tower",
            "artist": "Dale Chihuly",
            "date": 2017,
            "dimensions": "11 x 9 x 9'",
            "textDescription": "The initial phase of extensive experimentation with the Chandeliers culminated in the Chihuly Over Venice project (1995-1996), during which Chihuly varied both the shapes of the glass forms and the armatures themselves. Subsequent projects contined to challenge the artist to create large sculptures for spaces without ceilings or where the ceilings could not bear the weight of Chandeliers, giving life to the development of the Tower series.\nThe Sapphire Icicle Tower, which stands at eleven feet, exemplifies Chihuly's desire to mass color on a steel armature for dramatic efffect. Its approximately 325 pieces create what he calls a core of color.",
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
    
    //Returns an array of Artworks of all the documents in the collection
    class func getAllDocumentsInCollection(completion: @escaping ([Artwork], Error?) -> Void) {
        let database = Firestore.firestore()
        var artworks = [Artwork]()
        database.collection("Artwork").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion([Artwork](), err)
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    print(data["images"])
                    if let urlStrings = data["images"] as? [String] {
                        NetworkManager.getImagesWith(urlStrings: urlStrings, completion: { (images) in
                            
                            let newArtwork = Artwork(title: data["title"] as! String, artist: (data["artist"] as? String)!, dimensions: data["dimensions"] as? String, date: "", floor: data["floor"] as? Int, textDescription: data["textDescription"] as? String, medium: data["medium"] as? String, location: data["location"] as? GeoPoint, images: images)
                            
                            artworks.append(newArtwork)
                            if artworks.count == querySnapshot!.documents.count {
                                completion(artworks, nil)
                            }
                            print("Artwork: \(newArtwork.title!)")
                        })
                    }
                }
            }
        }
    }
    
    class func getMapArtworks(completion: @escaping ([Artwork], Error?) -> Void) {
        let database = Firestore.firestore()
        var artworks = [Artwork]()
        database.collection("MapArtworks").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion([Artwork](), err)
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    print(data["images"])
                    if let urlStrings = data["images"] as? [String] {
                        NetworkManager.getImagesWith(urlStrings: urlStrings, completion: { (images) in
                            
                            let newArtwork = Artwork(title: data["title"] as! String, artist: (data["artist"] as? String)!, dimensions: data["dimensions"] as? String, date: "", floor: data["floor"] as? Int, textDescription: data["textDescription"] as? String, medium: data["medium"] as? String, location: data["location"] as? GeoPoint, images: images)
                            
                            artworks.append(newArtwork)
                            if artworks.count == querySnapshot!.documents.count {
                                completion(artworks, nil)
                            }
                            print("Artwork: \(newArtwork.title!)")
                        })
                    }
                }
            }
        }
    }
    
    class func getArtists(completion: @escaping ([Artist], Error?) -> Void) {
        let database = Firestore.firestore()
        var artists = [Artist]()
        database.collection("Artist").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print ("Error geting document \(err)")
                completion([Artist](), err)
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    if let urlStrings = data["images"] as? [String] {
                        NetworkManager.getImagesWith(urlStrings: urlStrings, completion: { (images) in
                            let newArtist = Artist(name: data["name"] as! String, textDesc: data["textDesc"] as! String, images: images)
                            artists.append(newArtist)
                            if artists.count == querySnapshot!.documents.count {
                                completion(artists, nil)
                            }
                            print ("Artist: \(newArtist.name)")
                        })
                    }
                }
            }
        }
    }
    
    class func getEvents(completion: @escaping ([Event], Error?) -> Void) {
        let database = Firestore.firestore()
        var events = [Event]()
        database.collection("Events").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print ("Error geting document \(err)")
                completion([Event](), err)
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
//                    if let urlStrings = data["images"] as? [String] {
//                        NetworkManager.getImagesWith(urlStrings: urlStrings, completion: { (images) in
                    
                    let newEvent = Event(title: data["title"] as! String, date: data["startTime"] as! String, summary: data["description"] as! String, image: UIImage(named: "logo2")!, location: data["location"] as? String)
                    DispatchQueue.main.async {
                        print(newEvent.summary)
                        if let eventSummaryArr = newEvent.summary?.components(separatedBy: "&&") {
                            let str = eventSummaryArr[0]
                            print(str)
                            if let url = URL(string: str)
                            {
                                let url2 = url
                                getData(from: url2) { data, response, error in
                                    guard let data = data, error == nil else { print(error)
                                        return }
                                    
                                    //print("heloooooo2")
                                    DispatchQueue.main.async() {
                                        newEvent.image = UIImage(data: data)!
                                        //print("heloooooo")
                                    }
                                    
                                    completion(events, nil)
                                }
                            }
                        }
                    }
                    
                   // newEvent.image =
                            events.append(newEvent)
                            if events.count == querySnapshot!.documents.count {
                                completion(events, nil)
                            }
                            print ("Event: \(events.first?.title)")
//                        })
                    }
                }
            }
        }
    
    
    class func makeGeoPoint(lat: Double, long: Double) -> GeoPoint{
        let newPoint = GeoPoint(latitude: lat, longitude: long)
        return newPoint
    }
    
    class func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    class func sendFeedback(title: String, timestamp: Double, feedback: String, completion: @escaping (Bool) -> Void) {
        let database = Firestore.firestore()
        database.collection("Feedback").document("\(title)").setData([
            "\(timestamp)": feedback], merge: true) { err in
                if let err = err {
                    completion(false)
                    print("Error adding document: \(err)")
                } else {
                    completion(true)
                    print("Document added")
                }
        }
    }
    
}

