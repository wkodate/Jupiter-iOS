//
//  Article.swift
//  Jupiter
//
//  Created by wkodate on 2015/11/22.
//  Copyright © 2015年 wkodate. All rights reserved.
//

import Foundation

class Article {
    
    var title: String
    
    var link: String
    
    var rssTitle: String
    
    var created: String
    
    var imageUrl: String?

    var description: String?
    
    init(title: String, link:String, rssTitle: String, created: String, imageUrl: String, description: String) {
        self.title = title
        self.link = link
        self.rssTitle = rssTitle
        self.created = created
        self.imageUrl = imageUrl
        self.description = description
    }
    
}