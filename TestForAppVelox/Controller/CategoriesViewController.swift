//
//  CategoriesViewController.swift
//  TestForAppVelox
//
//  Created by Владислав Цветков on 22/11/2018.
//  Copyright © 2018 Владислав Цветков. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func closeBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cleanFilterBtnPressed(_ sender: UIButton) {
        for item in ItemsService.instance.rssItems {
            item.isShow = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemsService.instance.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = ItemsService.instance.categories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for item in ItemsService.instance.rssItems {
            item.isShow = (item.category == ItemsService.instance.categories[indexPath.row]) ? true : false
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
