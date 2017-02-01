//
//  GameItem.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/27/17.
//
//

protocol GameItem: Hashable, CustomStringConvertible {

    associatedtype GIPosition: GameItemPosition
    associatedtype GIType: GameItemType

    var type: GIType { get set }
    var position: GIPosition { get set }
}

class CCGameItem<GIPosition: GameItemPosition, GIType: GameItemType>: GameItem {

    var type: GIType
    var position: GIPosition

    var hashValue: Int {
        return position.hashValue + position.hashValue
    }

    var description: String {
        return "\(type) at: \(position)"
    }

    init(type: GIType, position: GIPosition) {
        self.type = type
        self.position = position
    }
}

extension CCGameItem: Equatable {
    static func == (lhs: CCGameItem, rhs: CCGameItem) -> Bool {
        return lhs.position == rhs.position // dirty hack && lhs.type == rhs.type
    }
}




