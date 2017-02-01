//
//  GameRule.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/27/17.
//
//


protocol GameRule {
    //var condition: GameCondition  { get set }
    var action: GameAction { get set }
}


class CCGameRule: GameRule {

     //var condition: GameCondition
     var action: GameAction

     //init(condition: GameCondition, action: GameAction) {
    init(action: GameAction) {
        self.action = action
    }
}

