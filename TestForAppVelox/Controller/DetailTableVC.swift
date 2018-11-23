//
//  DetailTableVC.swift
//  TestForAppVelox
//
//  Created by Владислав Цветков on 22/11/2018.
//  Copyright © 2018 Владислав Цветков. All rights reserved.
//

import UIKit

class DetailTableVC: UITableViewController {
    
    var rssItem: RSSItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCellReuseIdentifier, for: indexPath) as! DetailTableViewCell
        
        guard let rssItem = rssItem else {
            return UITableViewCell()
        }
        
        cell.setupView(withImage: rssItem.imageLink, title: rssItem.title, fullText: rssItem.fullText)
        
        return cell
    }
}
