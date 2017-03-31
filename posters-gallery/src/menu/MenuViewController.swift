//
//  MenuViewController.swift
//  posters-gallery
//
//  Created by Developer on 3/28/17.
//  Copyright © 2017 Sergey Melnik (smelnik.means.me@gmail.com). All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    private var isInitialized = false
    @IBOutlet weak private var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isInitialized {
            isInitialized = true
            initiallySelectMenuItem()
        }
    }
    
    private func initiallySelectMenuItem() {
        self.tableView.selectRow(at: MenuDelegate.selectedIndexPath, animated: false, scrollPosition: .none)
        let delegate = self.tableView.delegate as! MenuDelegate
        delegate.selectRow(at: MenuDelegate.selectedIndexPath, for: self.tableView)
    }
}
