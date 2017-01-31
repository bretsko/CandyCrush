//
//  BoardFactory.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/30/17.
//
//

import Foundation

class GameBoardFactory {

    public func makeRandomBoard2D(length: Int, percentsFilled: Int) -> CCGameBoard2D? {

        guard percentsFilled < 100 else { return nil }

        let board = CCGameBoard2D(maxX: length, maxY: length)

        var items = Set<CCGameItem>()

        while(items.count < (length * length * percentsFilled / 100)) {
            let position = makeRandomPosition2D(max: length)
            let type = makeRandomType()
            let item = CCGameItem(type: type, position: position)
            items.insert(item)
        }

        board.items = Array(items)

//        for item in  items {
//            board.addItem(item)
//        }

        return board
    }

    public func makeRandomPosition2D(max: Int) -> CCGameItemPosition2D {
        let randomX = Int(arc4random_uniform(UInt32(max)))
        let randomY = Int(arc4random_uniform(UInt32(max)))
        return CCGameItemPosition2D(x: randomX, y: randomY)
    }

    public func makeRandomType() -> GameItemType {
        //total 3 types exist
        let number = Int(arc4random_uniform(UInt32(3)))
        return GameItemType(rawValue: number)!
    }

}





