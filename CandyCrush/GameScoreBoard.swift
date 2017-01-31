//
//  GameScoreBoard.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/27/17.
//
//

import Foundation

protocol GameScoreBoard {
    var scores: [ GamePlayer : Int ] { get set }
}

class CCGameScoreBoard: GameScoreBoard {
    
    var scores: [ GamePlayer : Int ]

    init(scores: [ GamePlayer : Int ]) {
        self.scores = scores
    }
}
