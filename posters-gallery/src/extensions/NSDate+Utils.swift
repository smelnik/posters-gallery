//
//  NSDate+Utils.swift
//  posters-gallery
//
//  Created by Developer on 3/30/17.
//  Copyright © 2017 Sergey Melnik (smelnik.means.me@gmail.com). All rights reserved.
//

import Foundation

extension Date {
    static var dateFormatter = DateFormatter()
    
    func toString(with dateFormat: String = "dd-MMM-yyyy HH:mm") -> String {
        Date.dateFormatter.dateFormat = dateFormat
        return Date.dateFormatter.string(from: self)
    }
    
    init(unixTimestamp: TimeInterval, inMilliseconds: Bool = false) {
        self.init(timeIntervalSince1970: inMilliseconds ? unixTimestamp / 1000 : unixTimestamp)
    }
}
