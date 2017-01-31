//
//  GameItemChange.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/27/17.
//
//

enum GameItemChangeType {
    case remove, add, changeType(GameItemType)
}

protocol GameItemChange {

    associatedtype GameItemPosition

    var change: [ GameItemChangeType ] { get set }
    var position: GameItemPosition { get set }
}

struct CCGameItemChange: GameItemChange {

    typealias GameItemPosition = CCGameItemPosition2D

    var change: [GameItemChangeType]
    var position: CCGameItemPosition2D
}
