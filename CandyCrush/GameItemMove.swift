//
//  GameItemMove.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/27/17.
//
//

protocol GameItemMove: CustomStringConvertible, Hashable {

    associatedtype GIPosition: GameItemPosition

    var source: GIPosition { get set }
    var destination: GIPosition { get set }
}

class CCGameItemMove<GIPosition: GameItemPosition>: GameItemMove {

    var source: GIPosition
    var destination: GIPosition

    var description: String {
        return "from: \(source), to: \(destination)"
    }

    var hashValue: Int {
        return source.hashValue + destination.hashValue
    }

    init(source: GIPosition, destination: GIPosition) {
        self.source = source
        self.destination = destination
    }
}

extension CCGameItemMove: Equatable {
     static func == (lhs: CCGameItemMove, rhs: CCGameItemMove) -> Bool {
        return lhs.source == rhs.source && lhs.destination == rhs.destination
    }
}



