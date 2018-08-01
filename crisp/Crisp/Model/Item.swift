//
//  Items.swift
//  Crisp
//
//  Created by Rahim Siahpoosh on 2018-04-11.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import Foundation

class Item {
    var name: String!
    var quantity: Int!
    var price: Int!
    
    init(name: String) {
        self.name = name
        self.quantity = 0
        self.price = 0
    }

    public var description: String {
        return "Items:\(name) \(quantity)"
        
    }
}
