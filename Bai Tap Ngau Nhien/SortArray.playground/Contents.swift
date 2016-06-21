//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


func randomSortArray(numbers: [Int]) -> [Int] {
    var result: [Int] = numbers
    
    let length:UInt32 = UInt32(numbers.count / 2)
    func swap(fristIndex: Int, secondIndex: Int) {
        let tmp = result[fristIndex]
        result[fristIndex] = result[secondIndex]
        result[secondIndex] = tmp
    }
    for i in 0  ..< numbers.count  {
        let randomIndex: Int = Int(arc4random_uniform(length))
        swap(i, secondIndex: randomIndex)
    }
    return result
}



var numbers = [12,31,33,49,52,56,69]
let randomNumbers = randomSortArray(numbers)







