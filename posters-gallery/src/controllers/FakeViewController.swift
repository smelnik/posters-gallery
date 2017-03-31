//
//  FakeViewController.swift
//  posters-gallery
//
//  Created by Developer on 3/29/17.
//  Copyright © 2017 Sergey Melnik (smelnik.means.me@gmail.com). All rights reserved.
//

import UIKit

class FakeViewController: UIViewController {

    @IBOutlet weak fileprivate var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "\(parent?.title ?? "Fake") Screen"
    }
}
