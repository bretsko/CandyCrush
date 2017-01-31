//
//  BoardFactory.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/30/17.
//
//

class GameBoardFactory {

    public func makeRandomSquareBoard2D(length: Int, percentsFilled: Int) -> CCGameBoard2D? {

        guard percentsFilled < 100 else { return nil }

        let board = CCGameBoard2D(maxX: length, maxY: length)

        var items = Set<CCGameItem>()

        //random board must contain at least one Candy
        func checkComposition() -> Bool {
            return items.contains(where: { $0.type == .Candy })
        }

        func checkQuantity() -> Bool {
            return items.count >= (length * length * percentsFilled / 100)
        }

        while( !checkQuantity() || !checkComposition() ) {
            let position = makeRandomPosition2D(max: length)
            let type = makeRandomType()
            let item = CCGameItem(type: type, position: position)
            if (checkQuantity() && !checkComposition()) {
                items.update(with: item)
            } else {
                items.insert(item)
            }
        }

        board.items = Array(items)
        return board
    }

    public func makeRandomPosition2D(max: Int) -> CCGameItemPosition2D {
        let randomX = randomInt(max: max)
        let randomY = randomInt(max: max)
        return CCGameItemPosition2D(x: randomX, y: randomY)
    }

    public func makeRandomType() -> GameItemType {
        //total 3 types exist
        let number = randomInt(max:3)
        return GameItemType(rawValue: number)!
    }

}





