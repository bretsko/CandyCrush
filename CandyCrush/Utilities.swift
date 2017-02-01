//
//  Utilities.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/30/17.
//
//

import Foundation

func stringToNumbers(_ string: String, numberOfElements: Int) -> [Int]? {
    let numbers = string.components(separatedBy: " ").map{ Int($0) }.flatMap{ $0 }
    if numbers.count != numberOfElements {
        return nil
    }
    return numbers
}

func randomInt(max: Int) -> Int {
    return Int(arc4random_uniform(UInt32(max)))
}

func randomBool() -> Bool {
    return arc4random_uniform(2) == 0
}
