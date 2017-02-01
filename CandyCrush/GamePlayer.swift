//
//  GamePlayer.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/27/17.
//
//


class GamePlayer: Hashable  {

    let name: String

    var hashValue: Int {
        return name.hashValue
    }

    init(name: String) {
        self.name = name
    }
}

extension GamePlayer: Equatable {
    static func == (lhs: GamePlayer, rhs: GamePlayer) -> Bool {
        return lhs.name == rhs.name
    }
}
