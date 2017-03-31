//
//  UIImageView+Utils.swift
//  posters-gallery
//
//  Created by Developer on 3/30/17.
//  Copyright © 2017 Sergey Melnik (smelnik.means.me@gmail.com). All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(with url: URL?, completion: @escaping () -> Void) {
        image = nil
        
        if let url = url {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async() {
                        completion()
                    }
                    return
                }
                
                DispatchQueue.main.async() {
                    self.image = UIImage(data: data)
                    completion()
                }
            }.resume()
            
            return
        }
        
        completion()
    }
}
