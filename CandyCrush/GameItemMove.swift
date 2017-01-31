//
//  GameItemMove.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/27/17.
//
//

protocol GameItemMove {

    associatedtype GameItemPosition

    var source: GameItemPosition { get set }
    var destination: GameItemPosition { get set }
}

class CCGameItemMove: GameItemMove, CustomStringConvertible {

    typealias GameItemPosition = CCGameItemPosition2D

    var source: GameItemPosition
    var destination: GameItemPosition

    var description: String {
        return "from: \(source), to: \(destination)"
    }

    init(source: GameItemPosition, destination: GameItemPosition) {
        self.source = source
        self.destination = destination
    }

}

extension CCGameItemMove: Equatable {
     static func == (lhs: CCGameItemMove, rhs: CCGameItemMove) -> Bool {
        return lhs.source == rhs.source && lhs.destination == rhs.destination
    }
}



