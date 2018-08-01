//: Playground - noun: a place where people can play

import UIKit

class Order {
    var categories = [Category]()
    var order: Int!
    var pick: TimeAddress!
    var drop: TimeAddress!
    
    init() {
        
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

class Category {
    var items = [Item]()
    var name: String!
    var comment: String!
    
    init(name: String) {
        self.name = name
    }
}

class Item {
    var name: String!
    var quantity: Int!
    
    init(name: String) {
        self.name = name
        self.quantity = 0
    }
    
    public var description: String {
        return "Items:\(name) \(quantity)"
        
    }
}

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
let order = Order()
print(order.categories[2].name)
print(order.categories[0].items[1].name)
print(order.categories[0].items[1].quantity)

print("-----------------")
if order.categories.isEmpty == false {
    for i in 0..<order.categories.count {
        for x in 0..<order.categories[i].items.count {
        print(order.categories[i].items[x].quantity)
        }
    }
    print("There is no order that is higher than zero")
}

print("----------")

order.categories.forEach { (categories) in
    print("Test", categories.name)
    categories.items.forEach{ (items) in
        if items.quantity > 0 {
            print("There is value", items.quantity)
        } else {
            print("There is no value")
        }
    }
}
print("----------------------------")
print("----------------------------")


var mandict = [Int : String]()
var womandict = [Int : String]()
var homedict = [Int : String]()

for i in 0..<order.categories.count {
    if order.categories[i].name == "man" {
        //print(order.categories[i].name)
        for x in 0..<order.categories[i].items.count {
            print("\(order.categories[i].name!) \(order.categories[i].items[x].name!)")
            print("Nr: \(x)")
            mandict[x] = "\(order.categories[i].name!) \(order.categories[i].items[x].name!)"
        }
    }
}

for i in 0..<order.categories.count {
    if order.categories[i].name == "woman" {
        //print(order.categories[i].name)
        for x in 0..<order.categories[i].items.count {
            print("\(order.categories[i].name!) \(order.categories[i].items[x].name!)")
            print("Nr: \(x)")
            womandict[x] = "\(order.categories[i].name!) \(order.categories[i].items[x].name!)"
        }
    }
}

for i in 0..<order.categories.count {
    if order.categories[i].name == "home" {
        //print(order.categories[i].name)
        for x in 0..<order.categories[i].items.count {
            print("\(order.categories[i].name!) \(order.categories[i].items[x].name!)")
            print("Nr: \(x)")
            homedict[x] = "\(order.categories[i].name!) \(order.categories[i].items[x].name!)"
        }
    }
}

print("----------------------------")
mandict.forEach { (key, item) in
    print(key, item)
}

print("----------------------------")
var orderTest = [Any]()
var orderTesting = [String:Any]()

orderTest.append(homedict)
orderTest.append(womandict)
orderTest.append(mandict)

orderTest.forEach { (key) in
    print(key)
}
print("----------------------------")
var dict = [String: [String]]()
dict["man"] = ["shirt"]
dict["woman"] = ["dress"]
dict["home"] = ["carpet"]


var list = dict["man"] ?? []
list.append("pants")

dict["man"] = list

print(dict)

var dict3d = [String: Any]()

print("--------------------")
dict3d["ID"] = "1"
dict3d["man"] = ["shirt"]
dict3d["woman"] = ["dress"]
dict3d["home"] = ["\(order.categories[0].items[0].name!), \(order.categories[0].items[0].quantity!)"]
//dict3d["home"] = ["groda"]


print(dict3d)











