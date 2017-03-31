//
//  PostersDataSource.swift
//  posters-gallery
//
//  Created by Developer on 3/29/17.
//  Copyright © 2017 Sergey Melnik (smelnik.means.me@gmail.com). All rights reserved.
//

import UIKit

class PostersDataSource: NSObject {
    
    fileprivate static let kPosterImageViewWidth: CGFloat = 35
    
    fileprivate var allData: [Poster]
    fileprivate var filteredData: [Poster]
    fileprivate var filterString: String

    override init() {
        allData = []
        filteredData = []
        filterString = ""
    }
}

extension PostersDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let poster = filteredData[indexPath.row]
        
        cell.titleLabel.text = poster.name
        cell.subtitleLabel.text = poster.time.toString()
        
        cell.posterImageViewWidthConstraint.constant = 0
        cell.posterImageView.loadImage(with: poster.imageURL) {
            if let updateCell = tableView.cellForRow(at: indexPath) as? PosterCell {
                if updateCell.posterImageView.image == nil {
                    updateCell.posterImageViewWidthConstraint.constant = 0
                } else {
                    updateCell.posterImageViewWidthConstraint.constant = PostersDataSource.kPosterImageViewWidth
                }
                
                updateCell.setNeedsLayout()
                updateCell.layoutIfNeeded()
            }
        }
        
        return cell
    }
}

extension PostersDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterDetailsCell",
                                                      for: indexPath) as! PosterDetailsCell
        let poster = filteredData[indexPath.item]
        cell.subtitleLabel.text = poster.summary
        cell.posterImageView.loadImage(with: poster.imageURL) {
            if let updateCell = collectionView.cellForItem(at: indexPath) as? PosterDetailsCell {
                updateCell.setNeedsLayout()
                updateCell.layoutIfNeeded()
            }
        }
        return cell
    }
}

// MARK: - Load/fetch data
extension PostersDataSource {
    func poster(at indexPath: IndexPath) -> Poster {
        return filteredData[indexPath.row]
    }
    
    func reloadData(completion:@escaping () -> Void) {
        Poster.posters { (posters) in
            self.allData = posters
            self.updateFilteredData()
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func applyFilter(_ filter: String) {
        filterString = filter
        updateFilteredData()
    }
    
    fileprivate func updateFilteredData() {
        if filterString.isEmpty {
            filteredData = allData
            return
        }
        
        filteredData = allData.filter({ (poster) -> Bool in
            if poster.name.range(of: filterString, options: .caseInsensitive) != nil {
                return true
            }
            
            return false
        })
    }
}
