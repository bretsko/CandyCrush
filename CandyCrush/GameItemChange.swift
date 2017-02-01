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

    associatedtype GIPosition: GameItemPosition

    var change: [ GameItemChangeType ] { get set }
    var position: GIPosition { get set }
}

struct CCGameItemChange<GIPosition: GameItemPosition>: GameItemChange {

    var change: [GameItemChangeType]
    var position: GIPosition
}
