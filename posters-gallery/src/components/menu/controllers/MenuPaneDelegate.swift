//
//  MenuPaneDelegate.swift
//  posters-gallery
//
//  Created by Developer on 3/29/17.
//  Copyright © 2017 Sergey Melnik (smelnik.means.me@gmail.com). All rights reserved.
//

import UIKit

class MenuPaneDelegate: NSObject {
    static var selectedIndexPath = IndexPath(row: 1, section: 0)
    fileprivate static let kHeaderHeight: CGFloat = 41.0
}

extension MenuPaneDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MenuPaneDelegate.kHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = Bundle.main.loadNibNamed("MenuPaneHeaderView", owner: self, options: nil)?[0] as! MenuPaneHeaderView
        let dataSource = tableView.dataSource as! MenuPaneDataSource
        view.titleLabel.text? = dataSource.titleForHeaderInSection(section)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if MenuPaneDelegate.selectedIndexPath == indexPath {
            return
        }
        MenuPaneDelegate.selectedIndexPath = indexPath
        
        selectRow(at: indexPath, for: tableView)
    }
    
    func selectRow(at indexPath: IndexPath, for tableView: UITableView) {
        let dataSource = tableView.dataSource as! MenuPaneDataSource
        let menuItem = dataSource.menu.sections[indexPath.section].items[indexPath.row]
        if let viewControllerType = menuItem.viewControllerType {
            let storyboard = UIStoryboard(name: "Content", bundle: nil)
            let identifier = String(describing: viewControllerType)
            let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
            viewController.title = viewController.title ?? menuItem.title
            
            let menuViewController = AppDelegate.shared().menuViewController
            menuViewController.show(viewController: viewController)
        }
    }
}
