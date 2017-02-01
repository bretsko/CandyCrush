//
//  GameItemType.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 2/1/17.
//
//

protocol GameItemType: CustomStringConvertible {
    static func random() -> GameItemType
}

struct CCGameItemType: GameItemType {

    var kind: GameItemKind
    var color: GameItemColor
    var bonus: Bool

    var description: String {
        return "kind: \(kind), color: \(color), bonus: \(bonus)"
    }

    static func random() -> GameItemType {
        return ccRandom()
    }

    static func ccRandom() -> CCGameItemType {
        return CCGameItemType(kind: GameItemKind.random(), color: GameItemColor.random(), bonus: randomBool())
    }
}

enum GameItemKind: String, CustomStringConvertible {
    case wall, candy

    var description: String {
        switch self {
            case .wall: return "Wall".onBlack
            case .candy: return "Candy".white
        }
    }

    static var array: [GameItemKind] {
        return [.wall, .candy]
    }

    static func random() -> GameItemKind {
        return array[randomInt(max: array.count - 1)]
    }
}

enum GameItemColor: String, CustomStringConvertible {
    case yellow, red, black, green

    var description: String {
        switch self {
            case .yellow: return "yellow".yellow
            case .red: return "red".red
            case .black: return "black".black
            case .green: return "green".green
        }
    }

    static var array: [GameItemColor] {
        return [.yellow, .red, .black, .green]
    }

    static func random() -> GameItemColor {
        return array[randomInt(max: array.count - 1)]
    }
}







