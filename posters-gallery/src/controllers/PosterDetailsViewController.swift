//
//  PosterDetailsViewController.swift
//  posters-gallery
//
//  Created by Developer on 3/30/17.
//  Copyright © 2017 Sergey Melnik (smelnik.means.me@gmail.com). All rights reserved.
//

import UIKit

class PosterDetailsViewController: UIViewController {
    
    fileprivate static let kAnimationDuration: TimeInterval = 0.125
    
    var currentIndex: Int! = 0
    var dataSource: PostersDataSource!
    fileprivate var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak fileprivate var collectionView: UICollectionView!
    fileprivate var isInitializedContentOffset = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizer()
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !isInitializedContentOffset {
            isInitializedContentOffset = true
            setupContentOffset()
            updateTitle()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView.alpha = 0
        updateCurrentIndex()
        
        coordinator.animate(alongsideTransition: nil) { context in
            self.setupContentOffset()
            
            UIView.animate(withDuration: PosterDetailsViewController.kAnimationDuration) {
                self.collectionView.alpha = 1
            }
        }
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    fileprivate func setupGestureRecognizer() {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PosterDetailsViewController.handleTapGesture(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc fileprivate func handleTapGesture(_ recognizer: UITapGestureRecognizer) {
        collectionView.collectionViewLayout.invalidateLayout()
        navigationController!.isNavigationBarHidden = !navigationController!.isNavigationBarHidden
    }
    
    fileprivate func setupCollectionView() {
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
    
    fileprivate func setupContentOffset() {
        let currentSize = collectionView.bounds.size
        let offset = CGFloat(currentIndex) * currentSize.width
        collectionView.contentOffset = CGPoint(x: offset, y: 0)
    }
    
    fileprivate func updateCurrentIndex() {
        let currentOffset = collectionView.contentOffset
        currentIndex = Int(currentOffset.x / collectionView.frame.width)
    }
    
    fileprivate func updateTitle() {
        self.navigationItem.title = self.dataSource.poster(at: IndexPath(item: currentIndex, section: 0)).name
    }
}

extension PosterDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.collectionView.frame.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateCurrentIndex()
        updateTitle()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollViewDidEndDecelerating(scrollView)
    }
}
