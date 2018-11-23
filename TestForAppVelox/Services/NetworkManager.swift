//
//  NetworkManager.swift
//  TestForAppVelox
//
//  Created by Владислав Цветков on 21/11/2018.
//  Copyright © 2018 Владислав Цветков. All rights reserved.
//

import UIKit

extension NetworkManager {
    static let linkNews = "http://www.vesti.ru/vesti.rss"
}

public class NetworkManager {
    static let shared = NetworkManager()
    
    private var parser : RSSParser?
    
    public func getListNewsAsync(completion: @escaping ([RSSItem])->()) -> () {
        let queue = DispatchQueue.global()
        
        let compl : ([RSSItem])->() = { (items) in
            self.parser = nil
            DispatchQueue.main.async {
                completion(items)
            }
        }
        
        queue.async {
            self.parser = RSSParser()
            self.parser?.parserFeed(feedURL: NetworkManager.linkNews, completionHandler: compl)
        }
    }
    
}
