//
//  Order.swift
//  Crisp
//
//  Created by Rahim Siahpoosh on 2018-04-10.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import Foundation

class Order {
    var categories = [Category]()
    var order: Int!
    var pick: TimeAddress!
    var drop: TimeAddress!
    var sum: Int!
    
    init() {
        
        sum = 0 
        let categorySetup : Dictionary = [
            "man" : ["shirts", "shirt 5 pack", "suits", "suitjackets", "pants", "smokings", "smokings shirts"],
            "woman" : ["shirts", "shirt 5 pack", "suits", "suitjackets", "pants", "skirts", "dress"],
            "home" : ["carpets", "curtains", "sheets", "duvets", "pillowcases", "soffclothes"],
        ]
        
        categorySetup.forEach { (categoryName, itemNames) in
            
            let aNewCategory = Category(name: categoryName)
            itemNames.forEach { (itemName) in
                aNewCategory.items.append(Item(name: itemName))
            }
            
            categories.append(aNewCategory)
        }
    }
}







