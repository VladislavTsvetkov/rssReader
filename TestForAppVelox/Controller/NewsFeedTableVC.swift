//
//  NewsFeedTableVC.swift
//  TestForAppVelox
//
//  Created by Владислав Цветков on 21/11/2018.
//  Copyright © 2018 Владислав Цветков. All rights reserved.
//

import UIKit


class NewsFeedTableVC: UITableViewController {
    
    var itemsToShow = [RSSItem]()
    var refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView.addSubview(refresh)
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        makeArrayToShow()
        tableView.reloadData()
        if itemsToShow.count > 0 {
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
       
    }
    
    @objc private func loadData() {
        NetworkManager.shared.getListNewsAsync { [weak self] (parseItems) in
            ItemsService.instance.rssItems = parseItems
            DispatchQueue.main.async {
                self?.makeArrayToShow()
                ItemsService.instance.loadCategories()
                self?.refresh.endRefreshing()
                self?.tableView.reloadData()
            }
        }
    }
    
    func makeArrayToShow () {
        itemsToShow.removeAll()
        for item in ItemsService.instance.rssItems {
            if item.isShow {
                itemsToShow.append(item)
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemsToShow.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCellReuseIdentifier, for: indexPath) as? NewsTableViewCell {
            cell.setupView(title: itemsToShow[indexPath.row].title,
                        date: itemsToShow[indexPath.row].pubDate,
                        description: itemsToShow[indexPath.row].description)
        return cell
        }
        return UITableViewCell()
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TO_DETAIL_VC {
            if let indexPath = tableView.indexPathForSelectedRow,
                let dvc = segue.destination as? DetailTableVC {
                dvc.rssItem = itemsToShow[indexPath.row]
            }
        }
    }
    
}
