//
//  MenuPaneDataSource.swift
//  posters-gallery
//
//  Created by Developer on 3/29/17.
//  Copyright © 2017 Sergey Melnik (smelnik.means.me@gmail.com). All rights reserved.
//

import UIKit

class MenuPaneDataSource: NSObject {
    let menu: Menu
    
    override init() {
        let homeItem = MenuItem("Home", with: FakeViewController.self)
        let postersItem = MenuItem("Posters", with: PostersViewController.self)
        let settingsItem = MenuItem("Settings", with: FakeViewController.self)
        let mainSection = MenuSection("Main Items", items: [homeItem, postersItem, settingsItem])
        
        var fakeItems = [MenuItem]()
        for i in 1...20 {
            fakeItems.append(MenuItem("\(i) Item", with: FakeViewController.self))
        }
        let fakeSection = MenuSection("Fake Items", items: fakeItems)
        
        menu = Menu(sections: [mainSection, fakeSection])
    }
    
    func titleForHeaderInSection(_ section: Int) -> String {
        return menu.sections[section].title
    }
}

extension MenuPaneDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return menu.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        cell.textLabel?.text? = menu.sections[indexPath.section].items[indexPath.row].title
        cell.backgroundColor = cell.contentView.backgroundColor // iPad iOS 9 fix
        return cell
    }
}
