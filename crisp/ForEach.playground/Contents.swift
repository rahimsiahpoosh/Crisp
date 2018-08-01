//: Playground - noun: a place where people can play

import UIKit

var testArray : Array = ["Ralle", "Fredrika", "Cleo"]

testArray.forEach { (name) in
    print(name)
}

var testArrayNr = [2,4,6,8]

testArrayNr.forEach { (nr) in
    print(nr)
}

var testDic: Dictionary = ["Ralle" : 2, "Fredrika" : 4, "Cleo" : 6]

//This will print just key and value
for (key, numbers) in testDic {
    print(key, numbers)
}

var testDic1 = ["Ralle" : [2, 4, 6], "Fredrika" : [8, 10, 12], "Cleo" : [14, 16, 18]]

testDic1.forEach { (name, number) in
    print(name)
    number.forEach({ (nr) in
        print(nr)
    })
}

for key in testDic1.keys {
    testDic1[key]?.sort(by: <)
}


for (key, numbers) in testDic1 {
    print("Hello: \(key)")
    for number in numbers {
        print(number)
    }
}


