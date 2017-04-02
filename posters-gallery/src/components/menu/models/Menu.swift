//
//  Menu.swift
//  posters-gallery
//
//  Created by Developer on 3/29/17.
//  Copyright © 2017 Sergey Melnik (smelnik.means.me@gmail.com). All rights reserved.
//

import UIKit

class MenuItem {
    let viewControllerType: UIViewController.Type?
    let title: String
    
    init(_ title: String, with viewControllerType: UIViewController.Type?) {
        self.title = title
        self.viewControllerType = viewControllerType
    }
    
    func viewController() -> UIViewController? {
        return viewControllerType?.init()
    }
}

class MenuSection {
    let items: [MenuItem]
    let title: String
    
    init(_ title: String, items: [MenuItem]) {
        self.title = title
        self.items = items
    }
}

class Menu {
    let sections: [MenuSection]
    
    init(sections: [MenuSection]) {
        self.sections = sections
    }
}
