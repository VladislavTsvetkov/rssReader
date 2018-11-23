//
//  RSSParser.swift
//  TestForAppVelox
//
//  Created by Владислав Цветков on 21/11/2018.
//  Copyright © 2018 Владислав Цветков. All rights reserved.
//

import Foundation

class RSSParser: NSObject, XMLParserDelegate {
    
    private var rssItems : [RSSItem] = []
    private var dict : [String : String]?
    private var currentTag : String?
    private var foundCharacters : String = ""
    
    fileprivate var parserCompletionHandler: (([RSSItem]) -> ())?
    
    func parserFeed(feedURL: String, completionHandler: (([RSSItem]) -> ())?) -> Void {
        parserCompletionHandler = completionHandler
        
        guard let feedURL = URL(string: feedURL) else {
            assert(false, "feed URL is invalid !!!")
            return
        }
        
        URLSession.shared.dataTask(with: feedURL, completionHandler: { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else {
                print("No data fetched")
                return
            }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }).resume()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            dict = [:]
        } else if elementName == "enclosure" {
            dict?[RSSItem.kImageLink] = attributeDict[RSSItem.kImageLink]
        }
        else {
            currentTag = elementName
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        foundCharacters += string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
           if let map = dict,
            let item = RSSItem.itemWith(map) {
            rssItems.append(item)
            dict = nil
            }
        } else if let tag = currentTag {
            dict?[tag] = foundCharacters
        }
        
        currentTag = nil
        foundCharacters = ""
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(rssItems)
    }
}
