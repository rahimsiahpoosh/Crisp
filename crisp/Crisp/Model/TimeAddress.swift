//
//  Date.swift
//  Crisp
//
//  Created by Rahim Siahpoosh on 2018-04-13.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import Foundation

class TimeAddress {
    var date: String!
    var address: String!
    var time: String!
    var entryCode: Int
    
    init(date: String) {
        self.date = date
        self.address = ""
        self.time = ""
        self.entryCode = 0
    }
    
    convenience init() {
        self.init(date: "")
    }
}
