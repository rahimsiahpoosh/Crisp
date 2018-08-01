//: Playground - noun: a place where people can play

var word = "pants"

func testString(item: String) -> String{
    
    let testWord = "What "
    let newWord = testWord + item
    return newWord
}

print(testString(item: word))

func testNr(a:Int, b:Int) -> Int {
    let newNr = a + b
    return newNr
}

let sum = testNr(a: 6, b: 8)
print(sum)
