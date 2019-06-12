//
//  Artwork.swift
//  HealingArts
//
//  Created by Carly Cameron on 6/10/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase
import FirebaseFirestore

class Artwork {
    
    var title: String?
    var artist: String?
    var dimensions: String?
    var date: String?
    var floor: Int?
    var textDescription: String?
    var medium: String?
    var location: GeoPoint?
    var imageURLs: [String]?
    var images: [UIImage] = []
    
    init(title: String, artist: String, dimensions: String?, date: String?, floor: Int?, textDescription: String?, medium: String?, location: GeoPoint?, imageURLs: [String]?) {
        self.title = title
        self.artist = artist
        self.dimensions = dimensions
        self.date = date
        self.floor = floor
        self.textDescription = textDescription
        self.medium = medium
        self.location = location
        self.imageURLs = imageURLs
        self.images = makeImages(imageURLs: imageURLs!)
    }
    
    func makeImages(imageURLs: [String]) -> [UIImage]{
        var images: [UIImage] = []
        for imageURL in imageURLs {
            if imageURL == nil {
                print("image url does not exist")
            } else {
                let picURL = URL(string: imageURL)
                let session = URLSession.shared
                let task = session.dataTask(with: picURL!) { (data, response, error) in
                    print("inside block")
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        DispatchQueue.main.async {
                            images.append(UIImage(data: data!)!)
                        }
                    }
                }
                task.resume()
            }
            
        }
        return images
    }
    
}
