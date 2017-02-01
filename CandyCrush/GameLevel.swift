//
//  GameLevel.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/27/17.
//
//


protocol GameLevel {

    var moves: Int { get set }

    var rules: [GameRule] { get set }

   // var finishCondition: GameCondition { get set }

}

class CCGameLevel: GameLevel {

    var moves: Int
    var rules: [GameRule]
    //var finishCondition: GameCondition

    init(moves: Int, rules: [GameRule]) { //, finishCondition: GameCondition) {
        //self.finishCondition = finishCondition
        self.moves = moves
        self.rules = rules
    }
    
}
