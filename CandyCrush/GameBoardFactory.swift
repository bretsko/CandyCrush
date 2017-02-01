//
//  BoardFactory.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/30/17.
//
//
protocol GameBoardFactory {

    associatedtype GBFBoard: GameBoard

    typealias GBFItem = GBFBoard.GameBoardItem

    typealias GBFPosition = GBFItem.GIPosition
    typealias GBFItemType = GBFItem.GIType


    func makeRandomBoard(length: Int, percentsFilled: Int) -> GBFBoard?
}

class GameBoard2DFactory: GameBoardFactory {

    typealias GBFBoard = GameBoard2D
    typealias GBFItem = GameBoard2D.GameBoardItem
    typealias GBFPosition = GBFItem.GIPosition
    typealias GBFItemType = GBFItem.GIType


    func makeRandomBoard(length: Int, percentsFilled: Int) -> GameBoard2D? {
        return makeRandomSquareBoard2D(length: length, percentsFilled: percentsFilled)
    }

    public func makeRandomSquareBoard2D(length: Int, percentsFilled: Int) -> GameBoard2D? {

        guard length > 0 && percentsFilled > 0 && percentsFilled < 100 else { return nil }

        let board = GameBoard2D(maxX: length, maxY: length)

        var items = Set<GBFItem>()

        //random board must contain at least one Candy
        func checkComposition() -> Bool {
            return items.contains(where: { $0.type.kind == .candy })
        }

        func checkQuantity() -> Bool {
            return items.count >= (length * length * percentsFilled / 100)
        }


        while( !checkQuantity() || !checkComposition() ) {
            let position = GBFPosition.random(max: length)
            let type = GBFItemType.ccRandom()
            let item = GBFItem(type: type, position: position)
            if (checkQuantity() && !checkComposition()) {
                items.update(with: item)
            } else {
                items.insert(item)
            }
        }

        board.items = Array(items)
        return board
    }
}





