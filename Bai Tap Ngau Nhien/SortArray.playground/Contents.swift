//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func swapElement(inout a: Int, inout b: Int) {
    let tmp = a
    a = b
    b = tmp
}

func randomSortArray(inout numbers: [Int]) {
    let length:UInt32 = UInt32(numbers.count)
    for i in 0  ..< numbers.count  {
        let randomIndex: Int = Int(arc4random_uniform(length))
        swapElement(&numbers[i], b: &numbers[randomIndex])
    }
}


var numbers = [12,31,33,49,52,56,69]
randomSortArray(&numbers)







