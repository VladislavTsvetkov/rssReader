//
//  DetailTableViewCell.swift
//  TestForAppVelox
//
//  Created by Владислав Цветков on 22/11/2018.
//  Copyright © 2018 Владислав Цветков. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var fullTextLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupView(withImage imageLink: String?, title: String, fullText: String?) {
        if let imageLink = imageLink {
            newsImageView.isHidden = false
            getImage(imageLink: imageLink)
        }
        self.titleLbl.text = title
        self.fullTextLbl.text = fullText
    }
    
    private func getImage(imageLink: String) {
        guard let imageURL = URL(string: imageLink) else { return }
        let queue = DispatchQueue.global()
        queue.async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                     self.newsImageView.image = UIImage(data: data)
                }
            }
        }
    }

}
