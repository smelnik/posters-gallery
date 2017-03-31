//
//  Poster.swift
//  posters-gallery
//
//  Created by Developer on 3/29/17.
//  Copyright © 2017 Sergey Melnik (smelnik.means.me@gmail.com). All rights reserved.
//

import UIKit

class Poster {
    let itemID: Int
    let name: String
    let summary: String // 'description'
    let imageURL: URL
    let time: Date
    
    init?(with json: [String: Any]) {
        guard let itemIDString = json["itemId"] as? String,
            let itemID = Int(itemIDString),
            let name = json["name"] as? String,
            let summary = json["description"] as? String,
            let imageURLString = json["image"] as? String,
            let imageURL = URL(string: imageURLString),
            let timestampString = json["time"] as? String,
            let timestamp = Int(timestampString)
        else {
            return nil
        }
        
        self.itemID = itemID
        self.name = name
        self.summary = summary
        self.imageURL = imageURL
        self.time = Date(unixTimestamp: TimeInterval(timestamp),
                         inMilliseconds: timestampString.characters.count > 10)
    }
}

// MARK: Data Loader
extension Poster {
    static func posters(completion: @escaping ([Poster]) -> Void) {
        guard let url = URL(string: Configuration.postersURL) else {
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            var posters: [Poster] = []
            
            do {
                if let data = data, let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    for item in json {
                        if let poster = Poster(with: item) {
                            posters.append(poster)
                        }
                    }
                }
            } catch {
                completion([])
                return
            }
            
            completion(posters)
        }.resume()
    }
}
