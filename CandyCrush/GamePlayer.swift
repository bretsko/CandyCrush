//
//  GamePlayer.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/27/17.
//
//

import Foundation


class GamePlayer: Hashable  {

    var name: String

    func makeMove() {
        
    }

    var hashValue: Int {
        return name.hashValue
    }

    init(name: String) {
        self.name = name
    }
}

extension GamePlayer: Equatable {
    static func == (lhs: GamePlayer, rhs: GamePlayer) -> Bool {
        return lhs.name == rhs.name && lhs.name == rhs.name
    }
}
