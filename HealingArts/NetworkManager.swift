//
//  NetworkManager.swift
//  HealingArts
//
//  Created by Carly Cameron on 6/12/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import Foundation
import UIKit

enum NetworkManager {
    
    static private var session = URLSession(configuration: .default)
    
    static func getImageWithURL(url: URL, completion:@escaping (UIImage) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            if UIImage.init(data: data) != nil{
                let image = UIImage.init(data: data)!
                completion(image)
            } else {
                let image = UIImage(named: "artPlaceholderImage")
                completion(image!)
            }
            if let error = error {
                print(error)
            }
        }.resume()
    }
    
    static func getImagesWith(urlStrings: [String], completion:@escaping ([UIImage]) -> Void) {
        for urlString in urlStrings {
            let url = URL(string: urlString)
            var images = [UIImage]()
            self.getImageWithURL(url: url!) { (image) in
                images.append(image)
                if images.count == urlStrings.count {
                    completion(images)
                }
            }
        }
    }
}
