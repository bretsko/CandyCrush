//
//  GameLevelBuilder.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/30/17.
//
//


//protocol GameLevelBuilder {
//
//    associatedtype GameLevel
//
//    func buildLevel() -> GameLevel
//}
//
//
//class CCGameLevelBuilder: GameLevelBuilder {
//
//    typealias GameLevel = CCGameLevel
//
//    func buildLevel() -> GameLevel {
//        return buildLevel1()
//    }
//
//    public func buildLevel1() -> CCGameLevel {
//
//        let condition1Block: ((CCGameItemMove2D) -> Bool) = { CCGameItemMove2D in
//
//            return true
//        }
//
//        let condition1 = CCGameCondition(block: condition1Block)
//        let action1 = CCGameAction()
//
//        let rule1 = CCGameRule(condition: condition1, action: action1)
//
//        let rules = [rule1]
//
//        let finishConditionBlock: ((CCGameItemMove2D) -> Bool) = { CCGameItemMove2D in
//
//            return true
//        }
//
//        let finishCondition = CCGameCondition(block: condition1Block)
//
//        let level1 = CCGameLevel(moves: 10, rules: rules, finishCondition: finishCondition)
//
//        return level1
//    }
//
//
//
//}
