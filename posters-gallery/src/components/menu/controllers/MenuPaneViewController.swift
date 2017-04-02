//
//  MenuPaneViewController.swift
//  posters-gallery
//
//  Created by Developer on 3/28/17.
//  Copyright © 2017 Sergey Melnik (smelnik.means.me@gmail.com). All rights reserved.
//

import UIKit

class MenuPaneViewController: UIViewController {

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
        self.tableView.selectRow(at: MenuPaneDelegate.selectedIndexPath, animated: false, scrollPosition: .none)
        let delegate = self.tableView.delegate as! MenuPaneDelegate
        delegate.selectRow(at: MenuPaneDelegate.selectedIndexPath, for: self.tableView)
    }
}
