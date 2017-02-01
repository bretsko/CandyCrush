//
//  GameBoard.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/27/17.
//
//

protocol GameBoard {
    associatedtype GameBoardItem: GameItem
    var items: [ GameBoardItem ] { get set }
}

class GameBoard2D: GameBoard {

    typealias GameBoardItem = CCGameItem<CCGameItemPosition, CCGameItemType>

    var items = [ GameBoardItem ]()

    let maxX: Int
    let maxY: Int

    init(maxX: Int, maxY: Int) {
        self.maxX = maxX
        self.maxY = maxY
    }
}

extension GameBoard2D: CustomStringConvertible {

    var description: String {

        items.sort(by: { $0.position < $1.position })
        var result = "Game board:"
        let delimiter =  "\n" + String(repeating: "= ", count: maxX * 4) + "\n" // -> "= = = = = "
        result += delimiter

        for y in 0..<maxY {
            for x in 0..<maxX {
                if let item = items.filter({ $0.position.x == x && $0.position.y == y }).first {
                    result += (item.type.description + "(\(item.position))")
                } else {
                    result += "Empty(x: \(x), y: \(y))".lightBlack
                }
                x == (maxX - 1) ? (result += "\n") : (result += "\t")
            }
        }

        result += delimiter
        return result
    }
}






