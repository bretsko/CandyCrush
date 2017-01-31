//
//  GameItem.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/27/17.
//
//

enum GameItemType: Int, CustomStringConvertible {
    case Wall, Candy, Bonus

    var description: String {
        switch self {
            case .Wall: return "Wall".onBlack
            case .Candy: return "Candy".blue
            case .Bonus: return "Bonus".red
        }
    }
}

protocol GameItem {

    associatedtype GameItemPosition

    var type: GameItemType { get set }
    var position: GameItemPosition { get set }
}

class CCGameItem: Hashable, CustomStringConvertible {

    typealias GameItemPosition = CCGameItemPosition2D

    var type: GameItemType
    var position: GameItemPosition

    var hashValue: Int {
        return position.hashValue + position.hashValue
    }

    var description: String {
        return "\(type) at: \(position)"
    }

    init(type: GameItemType, position: GameItemPosition) {
        self.type = type
        self.position = position
    }
}

extension CCGameItem: Equatable {
    static func == (lhs: CCGameItem, rhs: CCGameItem) -> Bool {
        return lhs.position == rhs.position // dirty hack && lhs.type == rhs.type
    }
}




