//
//  UIColor+Utils.swift
//  posters-gallery
//
//  Created by Developer on 4/1/17.
//  Copyright © 2017 Sergey Melnik (smelnik.means.me@gmail.com). All rights reserved.
//

import UIKit

extension UIColor {
    static var fbBlue: UIColor {
        return UIColor(r: 59, g: 89, b: 152)
    }
    
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }
}
