//
//  GameItemMove.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/27/17.
//
//

import Foundation

protocol GameItemMove {

    associatedtype GameItemPosition

    var oldPosition: GameItemPosition { get set }
    var newPosition: GameItemPosition { get set }
}

class CCGameItemMove: GameItemMove, CustomStringConvertible {

    typealias GameItemPosition = CCGameItemPosition2D

    var oldPosition: GameItemPosition
    var newPosition: GameItemPosition

    var description: String {
        return "from: \(oldPosition), to: \(newPosition)"
    }

    init(oldPosition: GameItemPosition, newPosition: GameItemPosition) {
        self.oldPosition = oldPosition
        self.newPosition = newPosition
    }

}

extension CCGameItemMove: Equatable {
     static func == (lhs: CCGameItemMove, rhs: CCGameItemMove) -> Bool {
        return lhs.oldPosition == rhs.oldPosition && lhs.newPosition == rhs.newPosition
    }
}



