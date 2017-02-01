//
//  Result.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 2/1/17.
//
//

enum Result: CustomStringConvertible {
    case OK(GameDataType?)
    case Error

    var description: String {
        let value = "" //TODO switch case
        return "value: \(value)"
    }
}
