//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func isSquareNumber(n: Int) -> Bool {
    let loop = Int(sqrt(Double(n)))
    for i in 1...loop {
        if i * i == n {
            return true
        }
    }
    return false
}

func squareNumbersLessThanOneHundred(condition: (Int) -> Bool) -> [Int]{
    var result = [Int]()
    for number in 2..<100 {
        if condition(number) {
            result.append(number)
        }
    }
    return result
}

func theFirstOneHundredSquareNumber() -> [Int] {
    var result = [Int]()
    var number = 4
    while result.count < 100 {
        if isSquareNumber(number) {
            result.append(number)
        }
        number += 1
    }
    return result
}

//Show the result
let listOfSquareNumberLessThan100 = squareNumbersLessThanOneHundred(isSquareNumber)
var listOfSquareNumerString = ""
for squareNumber in listOfSquareNumberLessThan100 {
    listOfSquareNumerString += String(squareNumber) + ", "
}
print(listOfSquareNumerString)


let listOfFirstOneHundredSquareNumber = theFirstOneHundredSquareNumber()
var listOfFirstOneHundredSquareNumberString = ""
for squareNumber in listOfFirstOneHundredSquareNumber {
    listOfFirstOneHundredSquareNumberString += String(squareNumber) + ", "
}
print(listOfFirstOneHundredSquareNumberString)


