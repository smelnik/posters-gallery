//
//  MenuContainerViewController.swift
//  posters-gallery
//
//  Created by Developer on 3/28/17.
//  Copyright © 2017 Sergey Melnik (smelnik.means.me@gmail.com). All rights reserved.
//

import UIKit

enum MenuPaneState {
    case closed
    case opened
}

class MenuContainerViewController: UIViewController {
    
    fileprivate struct Constants {
        static let iPadLeftPaneWidth: CGFloat = 320
        static let iPhoneInLandscapeLeftPaneWidth: CGFloat = 260
        static let iPhoneInPortraitLeftPaneGap: CGFloat = 60.0
        static let shadowOpacity: Float = 0.8
        static let menuAnimationDuration: TimeInterval = 0.125
    }
    
    @IBOutlet weak fileprivate var menuContainerView: UIView!
    @IBOutlet weak fileprivate var contentContainerView: UIView!
    
    fileprivate var menuViewController: MenuPaneViewController!
    fileprivate var contentViewController: MenuContentViewController!

    @IBOutlet weak fileprivate var menuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak fileprivate var menuWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak fileprivate var contentTrailingConstraint: NSLayoutConstraint!
    
    var menuPaneState: MenuPaneState = UIDevice.isPhone() ? .closed : .opened
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLeftPane()
        addGestureRecognizers()
    }
    
    override func updateViewConstraints() {
        updateLeftPane()
        super.updateViewConstraints()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { context in
            self.view.setNeedsUpdateConstraints()
        }
    }
    
    fileprivate func toggleLeftPane() {
        menuPaneState = menuPaneState == .closed ? .opened : .closed
        updateAndAnimateLeftPane()
    }
    
    fileprivate func updateAndAnimateLeftPane() {
        updateLeftPane()
        
        if menuPaneState == .opened {
            updateMenuShadow()
        }
        
        UIView.animate(withDuration: Constants.menuAnimationDuration, animations: {
            self.view.layoutIfNeeded()
        }, completion: { isFinished in
            if self.menuPaneState == .closed {
                self.updateMenuShadow()
            }
        })
    }
    
    fileprivate func updateLeftPane() {
        menuLeadingConstraint.constant = leftPaneOrigin()
        menuWidthConstraint.constant = leftPaneWidth()
        contentTrailingConstraint.constant = contentPaneTrailingConstant()
    }
    
    fileprivate func contentPaneTrailingConstant() -> CGFloat {
        return UIDevice.isPhone() ? -(leftPaneWidth() + menuLeadingConstraint.constant) : 0.0
    }
    
    fileprivate func leftPaneOrigin() -> CGFloat {
        return menuPaneState == .closed ? -leftPaneWidth() : 0.0
    }
    
    fileprivate func leftPaneWidth() -> CGFloat {
        if !UIDevice.isPhone() {
            return Constants.iPadLeftPaneWidth
        }
        
        return UIDevice.isLandscape()
            ? Constants.iPhoneInLandscapeLeftPaneWidth
            : view.frame.width - Constants.iPhoneInPortraitLeftPaneGap
    }
    
    fileprivate func updateMenuShadow() {
        let isNeedShowShadow = UIDevice.isPhone() && -menuLeadingConstraint.constant < leftPaneWidth()
        menuContainerView.layer.shadowOpacity = isNeedShowShadow ? Constants.shadowOpacity : 0.0
    }
}

// MARK: - Public methods
extension MenuContainerViewController {
    func show(viewController: UIViewController, title: String? = nil) {
        contentViewController.show(viewController: viewController, title: title)
        
        if UIDevice.isPhone() && menuPaneState == .opened {
            toggleLeftPane()
        }
    }
}

// MARK: - ContentViewControllerDelegate
extension MenuContainerViewController: MenuContentViewControllerDelegate {
    func menuButtonPressed() {
        toggleLeftPane()
    }
}

// MARK: - UIGestureRecognizerDelegate
extension MenuContainerViewController: UIGestureRecognizerDelegate {
    fileprivate func addGestureRecognizers() {
        if !UIDevice.isPhone() {
            return
        }
        
        let panAction = #selector(MenuContainerViewController.handlePanGesture(_:))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: panAction)
        view.addGestureRecognizer(panGestureRecognizer)
        
        let tapAction = #selector(MenuContainerViewController.handleTapGesture(_:))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: tapAction)
        tapGestureRecognizer.delegate = self
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let isTouchInMenuView = touch.view!.isDescendant(of: menuViewController.view)
        let isTouchInContentView = touch.view!.isDescendant(of: contentViewController.view)
        
        if isTouchInMenuView || (menuPaneState == .closed && isTouchInContentView) {
            return false
        }
        
        return true
    }
    
    @objc fileprivate func handleTapGesture(_ recognizer: UITapGestureRecognizer) {
        if menuPaneState == .opened {
            toggleLeftPane()
        }
    }
    
    @objc fileprivate func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        switch(recognizer.state) {
        case .began:
            break
        case .changed:
            let translation = recognizer.translation(in: view).x
            menuLeadingConstraint.constant = clampMenuLeadingConstant(with: translation)
            contentTrailingConstraint.constant = contentPaneTrailingConstant()
            updateMenuShadow()
            recognizer.setTranslation(CGPoint.zero, in: view)
        case .ended:
            menuPaneState = closestMenuPaneState()
            updateAndAnimateLeftPane()
        default:
            break
        }
    }
    
    fileprivate func closestMenuPaneState() -> MenuPaneState {
        return -menuLeadingConstraint.constant < leftPaneWidth() / 2.0 ? .opened : .closed
    }
    
    fileprivate func clampMenuLeadingConstant(with translation: CGFloat) -> CGFloat {
        return (-leftPaneWidth() ... 0.0).clamp(menuLeadingConstraint.constant + translation)
    }
}

// MARK: - Navigation
extension MenuContainerViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuPaneContainerSegue" {
            let navigationController = segue.destination as! UINavigationController
            menuViewController = navigationController.childViewControllers[0] as! MenuPaneViewController
            return
        }
        
        if segue.identifier == "MenuContentContainerSegue" {
            let navigationController = segue.destination as! UINavigationController
            contentViewController = navigationController.childViewControllers[0] as! MenuContentViewController
            contentViewController.delegate = self
            return
        }
    }
}
