//
//  Category.swift
//  Crisp
//
//  Created by Rahim Siahpoosh on 2018-05-18.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import Foundation

class Category {
    var items = [Item]()
    var name: String!
    var comment = ""
    
    init(name: String) {
        self.name = name
    }
}
