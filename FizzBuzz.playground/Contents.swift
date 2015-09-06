//: Playground - noun: a place where people can play

import UIKit

for number in 1...20 {
    print("\(number) ")
    if (number%3 == 0) {
        print("Fizz")
    }
    if (number%5 == 0) {
        print("Buzz")
    }
    println()
}