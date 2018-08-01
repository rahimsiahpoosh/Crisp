//
//  OrderService.swift
//  Crisp
//
//  Created by Rahim Siahpoosh on 2018-04-25.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import Foundation

class OrderService {
    
    init() {
        print("New OrderService created! :)")
    }
    
    func findCategoryByName(categories:[Category], name:String) -> Category{
        var match: Category!
        
        categories.forEach { (category) in
            if (category.name == name) {
                match = category
            }
        }
        
        if match == nil {
            print("No match")
        }
        
        return match
    }
    
    func validate(PickUpDate: String, DropDate: String, PickTime: String, DropTime: String, PickAddress: String, DropAddress: String) -> String {
        if (PickUpDate.isEmpty) && (DropDate.isEmpty) && (PickTime.isEmpty) && (DropTime.isEmpty) && (PickAddress.isEmpty) && (DropAddress.isEmpty)  {
            return "Kan det vara så att du var för snabb med att gå vidare och glömde att fylla Upp och Inlämning"
        } else if (PickUpDate.isEmpty) {
            return "Skriv in upphämtnings datum"
        } else if (DropDate.isEmpty) {
            return "Skriv in inlämnings datum"
        } else if (PickTime.isEmpty) {
            return "Skriv in upphämtnings tid"
        } else if (DropTime.isEmpty) {
            return "Skriv in inlämnings tid"
        } else if (PickAddress.isEmpty) {
            return "Skriv in upphämtnings adress"
        } else if (DropAddress.isEmpty) {
            return "Skriv in upphämtnings adress"
        }
        return ""
    }
}
    
