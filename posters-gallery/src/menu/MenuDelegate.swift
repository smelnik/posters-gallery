//
//  MenuDelegate.swift
//  posters-gallery
//
//  Created by Developer on 3/29/17.
//  Copyright © 2017 Sergey Melnik (smelnik.means.me@gmail.com). All rights reserved.
//

import UIKit

class MenuDelegate: NSObject {
    static var selectedIndexPath = IndexPath(row: 1, section: 0)
    fileprivate static let kHeaderHeight: CGFloat = 41.0
}

extension MenuDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MenuDelegate.kHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = Bundle.main.loadNibNamed("MenuHeaderView", owner: self, options: nil)?[0] as! MenuHeaderView
        let dataSource = tableView.dataSource as! MenuDataSource
        view.titleLabel.text? = dataSource.titleForHeaderInSection(section)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if MenuDelegate.selectedIndexPath == indexPath {
            return
        }
        MenuDelegate.selectedIndexPath = indexPath
        
        selectRow(at: indexPath, for: tableView)
    }
    
    func selectRow(at indexPath: IndexPath, for tableView: UITableView) {
        let dataSource = tableView.dataSource as! MenuDataSource
        let menuItem = dataSource.menu.sections[indexPath.section].items[indexPath.row]
        if let viewControllerType = menuItem.viewControllerType {
            let storyboard = UIStoryboard(name: "Content", bundle: nil)
            let identifier = String(describing: viewControllerType)
            let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
            
            let containerViewController = AppDelegate.shared().containerViewController
            containerViewController.showViewController(vc: viewController, title: menuItem.title)
        }
    }
}
