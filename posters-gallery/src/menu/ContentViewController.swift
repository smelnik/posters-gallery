//
//  ContentViewController.swift
//  posters-gallery
//
//  Created by Developer on 3/28/17.
//  Copyright © 2017 Sergey Melnik (smelnik.means.me@gmail.com). All rights reserved.
//

import UIKit

@objc
protocol ContentViewControllerDelegate {
    @objc optional func menuButtonPressed()
}

class ContentViewController: UIViewController {
    
    @IBOutlet weak fileprivate var containerView: UIView!
    var delegate: ContentViewControllerDelegate!
    
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
    
    
    func showViewController(vc: UIViewController, title: String? = nil) {
        self.title = title
        hideViewController()
        addChildViewController(vc)
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
        vc.view.layoutIfNeeded()
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
