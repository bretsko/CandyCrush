//
//  GameData.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 2/1/17.
//
//

enum GameDataType: String, CustomStringConvertible {
    // TODO: add more types
    case CCGameItemMove2D
    case Bool
    case Void

    var description: String {
        return self.rawValue
    }
}

enum GameData: CustomStringConvertible {
    // TODO: add more types
    case CCGameItemMove2D (CCGameItemPosition)
    case Bool(Bool)
    case Void

    var type: GameDataType {
        switch self {
            case .CCGameItemMove2D: return .CCGameItemMove2D
            case .Bool: return .Bool
            case .Void: return .Void
        }
    }

    var description: String {
        let value = "" //TODO switch case
        return "type: \(type.description), value: \(value)"
    }
}

