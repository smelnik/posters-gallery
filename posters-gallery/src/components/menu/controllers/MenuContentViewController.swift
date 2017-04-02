//
//  MenuContentViewController.swift
//  posters-gallery
//
//  Created by Developer on 3/28/17.
//  Copyright © 2017 Sergey Melnik (smelnik.means.me@gmail.com). All rights reserved.
//

import UIKit

@objc
protocol MenuContentViewControllerDelegate {
    @objc optional func menuButtonPressed()
}

class MenuContentViewController: UIViewController {
    
    @IBOutlet weak fileprivate var containerView: UIView!
    var delegate: MenuContentViewControllerDelegate!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupMenuButton()
    }
    
    fileprivate func setupMenuButton() {
        if !UIDevice.isPhone() {
            navigationItem.leftBarButtonItem = nil
        }
    }
    
    @IBAction fileprivate func menuAction(_ sender: Any) {
        delegate?.menuButtonPressed?()
    }
    
    
    func show(viewController: UIViewController, title: String? = nil) {
        self.title = title
        hideViewController()
        addChildViewController(viewController)
        viewController.view.frame = containerView.bounds
        containerView.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
        viewController.view.layoutIfNeeded()
    }
    
    fileprivate func hideViewController() {
        if childViewControllers.count == 0 {
            return
        }
        
        let childVC = childViewControllers[0]
        childVC.willMove(toParentViewController: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParentViewController()
    }
}
