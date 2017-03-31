//
//  UIDevice+Utils.swift
//  posters-gallery
//
//  Created by Developer on 3/28/17.
//  Copyright © 2017 Sergey Melnik (smelnik.means.me@gmail.com). All rights reserved.
//

import UIKit

extension UIDevice {
    class func isPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    class func isLandscape() -> Bool {
        return UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation)
    }
}
