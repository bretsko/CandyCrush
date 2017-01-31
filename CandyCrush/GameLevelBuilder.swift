//
//  GameLevelBuilder.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/30/17.
//
//

class GameLevelBuilder {

    public func buildLevel1() -> CCGameLevel {

        let condition1 = CCGameCondition()
        let action1 = CCGameAction()

        let rule1 = CCGameRule(condition: condition1, action: action1)

        let rules = [rule1]

        let finishCondition = CCGameCondition()

        let level1 = CCGameLevel(moves: 10, rules: rules, finishCondition: finishCondition)

        return level1
    }



}
