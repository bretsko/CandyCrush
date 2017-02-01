//
//  GameLogic.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/27/17.
//
//

protocol GameLogic {

    associatedtype GLBoard: GameBoard
    associatedtype GLItemMove: GameItemMove

    typealias GLItem = GLBoard.GameBoardItem
    typealias GIPosition = GLItem.GIPosition
    typealias GIType = GLItem.GIType

    var rules: [GameRule]  { get set }
    var board: GLBoard { get set }

    func checkMove(_ move: GLItemMove) -> Bool
    init(board: GLBoard, level: GameLevel)
}

class GameLogic2D: GameLogic {

    typealias GLBoard = GameBoard2D
    typealias GLItem = GLBoard.GameBoardItem//CCGameItem<GLItemPosition, GLItemType>
    typealias GLItemPosition = GLItem.GIPosition//CCGameItemPosition
    typealias GIType = GLItem.GIType
    typealias GLItemMove = CCGameItemMove<GLItemPosition>

    var board: GLBoard

    // loaded by GameRuleLoader - different levels can have diff rules
    var rules: [GameRule] //private?

    private var level: GameLevel

    required init(board: GLBoard, level: GameLevel) {
        self.level = level
        self.board = board
        self.rules = self.level.rules
        //self.init(board: board, rules: level.rules)
    }

//    required init(board: GameBoard, rules: [GameRule]) {
//        self.rules = rules
//        self.board = board
//    }


    func checkMove(_ move: GLItemMove) -> Bool {
        for rule in rules {
            guard checkMove(move, satisfies: rule) else { return false }
        }
        return true
    }

    private func checkMove(_ move: GLItemMove, satisfies rule: GameRule) -> Bool {

        guard let item = board.items.filter({ $0.position == move.source }).first else {
            print("Items can only be switched with each other")
            return false
        }

        let xdiff = abs(move.destination.x - move.source.x)
        let ydiff = abs(move.destination.y - move.source.y)

        guard (xdiff == 1 && ydiff == 0) || (xdiff == 0 && ydiff == 1) else {
            print("Only neighbouring items can be switched")
            return false
        }

        switch item.type.kind {
            case .wall:
                print("Wall cannot be moved")
                return false
            case .candy:
                return true
        }
    }

    func processMove(_ move: GLItemMove) -> Bool {

        if moveItem(at: move.source, to: move.destination) {

            // update score
            // update counters - movesLeft

            //movesLeft-=1
            //currentScore

        // if last move - save score per player, show message, load next level
        // if last level completed - save score per player, show scoreboard,

            calculateScore()
            return true
       }

        calculateScore()
        return false
    }

    func isItemMovable(at position: CCGameItemPosition) -> Bool {
        guard position.y < board.maxY && position.x < board.maxX else { return false }

        if let item = board.items.filter({ $0.position == position }).first {
            return item.type.kind != .wall
        }
        return false
    }


    func nextLevelReached() -> Bool {
        //TODO check score and other rules
        return false
    }

    func load(level: GameLevel) {
        // init counters - level, move

        self.level = level

        //        let level = levels[currentLevel]
        //
        //        let rules = level.rules
        //
        //        self.logic = CCGameLevelLogic(board: board, rules: rules)
        
        //movesLeft
        
    }

    private func calculateScore() {
        //TODO
    }

    private func moveItem(at position1: CCGameItemPosition, to position2: CCGameItemPosition) -> Bool {

        guard isItemMovable(at: position1) && isItemMovable(at: position2) else { return false }

        guard let item1 = board.items.filter({ $0.position == position1 }).first else { return false }
        guard let item2 = board.items.filter({ $0.position == position2 }).first else { return false }

        item1.position = position2
        item2.position = position1
        return true
    }

    private func moveItem(_ item: GLItem, to newPosition: CCGameItemPosition) -> Bool {
        guard removeItem(item) else { return false }

        item.position = newPosition

        return true
    }

    private func addItem(_ item: GLItem) -> Bool {
        guard canAddItem(at: item.position, with: item.type) else { return false }

        let item = CCGameItem(type: item.type, position: item.position)
        board.items.append(item)
        return true
    }

    private func removeItem(_ item: GLItem) -> Bool {
        guard isItemMovable(at: item.position) else { return false }

        board.items = board.items.filter({ $0 != item })
        return true
    }



    private func canAddItem(at position: CCGameItemPosition, with type: GameItemType) -> Bool {
        guard position.y < board.maxY && position.x < board.maxX else { return false }
        guard board.items.contains(where: { $0.position == position }) == false else {
            print("Failed to add item at position \(position), item already present")
            return false
        }
        return true
    }

    private func replaceItem(item1: GLItem, with item2: GLItem) -> Bool {
        if removeItem(item1) == true {
            return addItem(item2)
        }
        return false
    }


//    private func produceEffect(_ move: GLItemMove) -> CCGameEffect? {
//        // TODO check rules and board
//        return nil
//    }





}


