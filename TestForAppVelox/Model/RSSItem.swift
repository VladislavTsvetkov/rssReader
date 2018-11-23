//
//  RSSFeedItem.swift
//  TestForAppVelox
//
//  Created by Владислав Цветков on 21/11/2018.
//  Copyright © 2018 Владислав Цветков. All rights reserved.
//

import Foundation

extension RSSItem {
    // MARK: Dict conatsnts
    static let kTitle = "title"
    static let kDescription = "description"
    static let kPubDate = "pubDate"
    static let kCategory = "category"
    static let kImageLink = "url"
    static let kFullText = "yandex:full-text"
}

public class RSSItem {

    var title: String
    var description: String?
    var pubDate: Date
    var category: String
    var imageLink: String?
    var fullText : String?
    var isShow: Bool
    
    static func itemWith(_ dict: [String : String]) -> RSSItem? {
        
        //Tue, 20 Nov 2018 21:07:00 +0300x
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        if let dateS = dict[kPubDate],
            let date = formatter.date(from: dateS),
            let title = dict[kTitle],
            let category = dict[kCategory] {
            return RSSItem(withTitle: title,
                           descr: dict[kDescription],
                           pubDate: date,
                           category: category,
                           imageLink: dict[kImageLink],
                           fullText: dict[kFullText],
                           isShow: true)
        }
        return nil
    }
    
    init(withTitle title: String, descr : String?, pubDate: Date, category: String, imageLink: String?, fullText: String?, isShow: Bool) {
        self.title = title
        self.description = descr
        self.pubDate = pubDate
        self.category = category
        self.imageLink = imageLink
        self.fullText = fullText
        self.isShow = isShow
    }
}

class ItemsService {
    static let instance = ItemsService()
    
    var rssItems = [RSSItem]()
    var categories = [String]()
    
    func loadCategories() {
        var categoriesSet = Set<String>()
        for item in rssItems {
            categoriesSet.insert(item.category)
        }
        categories = categoriesSet.sorted()
    }
}
