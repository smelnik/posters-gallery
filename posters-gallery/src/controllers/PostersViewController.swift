//
//  PostersViewController.swift
//  posters-gallery
//
//  Created by Developer on 3/29/17.
//  Copyright © 2017 Sergey Melnik (smelnik.means.me@gmail.com). All rights reserved.
//

import UIKit

class PostersViewController: UIViewController {

    @IBOutlet weak fileprivate var tableView: UITableView!
    fileprivate var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSearchBar()
        scrollToHideSearchBar()
        
        dataSource().reloadData {
            self.tableView.reloadData()
        }
    }
    
    fileprivate func dataSource() -> PostersDataSource {
        return tableView.dataSource as! PostersDataSource
    }
}

extension PostersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - Search Bar functionality
extension PostersViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        updateFilteredResults(with: "")
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateFilteredResults(with: searchText)
    }
    
    fileprivate func updateFilteredResults(with searchText: String) {
        dataSource().applyFilter(searchText)
        tableView.reloadData()
    }
    
    fileprivate func addSearchBar() {
        let width = tableView.frame.width;
        let frame = CGRect(x: 0.0, y: 0.0, width: width, height: 44.0);
        searchBar = UISearchBar(frame: frame)
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.showsCancelButton = true
        searchBar.searchBarStyle = .minimal
        searchBar.barStyle = .black
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
    }
    
    fileprivate func scrollToHideSearchBar() {
        DispatchQueue.main.async() { // waits until the main run-loop ended
            self.tableView.contentOffset = CGPoint(x: 0, y: self.tableView.tableHeaderView!.frame.height)
        }
    }
}

// MARK: - Navigation
extension PostersViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PosterDetailsSegue" {
            let navigationController = segue.destination as! UINavigationController
            let detailsViewController = navigationController.childViewControllers[0] as! PosterDetailsViewController
            let cell = sender as! PosterCell
            let indexPath = tableView.indexPath(for: cell)
            
            if let indexPath = indexPath {
                detailsViewController.dataSource = dataSource()
                detailsViewController.currentIndex = indexPath.item
            }
        }
    }
    
    @IBAction fileprivate func unwindToPosters(segue: UIStoryboardSegue) {
        // MARK: don't remove this func
    }
}
