//
//  NewsTableViewCell.swift
//  TestForAppVelox
//
//  Created by Владислав Цветков on 22/11/2018.
//  Copyright © 2018 Владислав Цветков. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupView(title: String, date: Date, description: String?) {
        self.titleLbl.text = title
        self.dateLbl.text = getForrmatedDate(date: date)
        self.descriptionLbl.text = description
    }
    
    private func getForrmatedDate(date: Date?) -> String? {
        guard let date = date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        
        return dateFormatter.string(from: date)
    }
    
}
