//
//  GameLogic.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/27/17.
//
//

protocol GameLogic {

    associatedtype GameItemMove
    associatedtype GameBoard

    var rules: [GameRule]  { get set }
    var board: GameBoard { get set }
}

class CCGameLevelLogic: GameLogic {

    typealias GameItemMove = CCGameItemMove
    typealias GameBoard = CCGameBoard2D

    var board: GameBoard

    // loaded by GameRuleLoader - different levels can have diff rules
    var rules: [GameRule]

    var level: GameLevel

    init(board: GameBoard, level: GameLevel) {
        self.level = level
        self.board = board
        self.rules = self.level.rules
        //self.init(board: board, rules: level.rules)
    }

//    required init(board: GameBoard, rules: [GameRule]) {
//        self.rules = rules
//        self.board = board
//    }

    func checkMove(_ move: GameItemMove) -> Bool {

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

        switch item.type {
            case .Wall:
                print("Wall cannot be moved")
                return false
            case .Candy, .Bonus:
                return true
        }
    }

    func processMove(_ move: GameItemMove) -> Bool {

        //if moveItem(at: move.oldPosition, to: move.newPosition) {

            // update score
            // update counters - movesLeft

            //movesLeft-=1
            //currentScore

            calculateScore()
            return true
       // }

       // calculateScore()
        //return false
    }

    func calculateScore() {
        //TODO
    }

    func nextLevelReached() -> Bool {
        //TODO check score and other rules
        return false
    }

    func moveItem(at position1: CCGameItemPosition2D, to position2: CCGameItemPosition2D) -> Bool {

        guard isItemMovable(at: position1) && isItemMovable(at: position2) else { return false }

        guard let item1 = board.items.filter({ $0.position == position1 }).first else { return false }
        guard let item2 = board.items.filter({ $0.position == position2 }).first else { return false }

        item1.position = position2
        item2.position = position1
        return true
    }

    func moveItem(_ item: CCGameItem, to newPosition: CCGameItemPosition2D) -> Bool {
        guard removeItem(item) else { return false }

        item.position = newPosition

        return true
    }

    func addItem(_ item: CCGameItem) -> Bool {
        guard canAddItem(at: item.position, with: item.type) else { return false }

        let item = CCGameItem(type: item.type, position: item.position)
        board.items.append(item)
        return true
    }

    func removeItem(_ item: CCGameItem) -> Bool {
        guard isItemMovable(at: item.position) else { return false }

        board.items = board.items.filter({ $0 != item })
        return true
    }

    func isItemMovable(at position: CCGameItemPosition2D) -> Bool {
        guard position.y < board.maxY && position.x < board.maxX else { return false }

        if let item = board.items.filter({ $0.position == position }).first {
            return item.type != .Wall
        }
        return false
    }

    func canAddItem(at position: CCGameItemPosition2D, with type: GameItemType) -> Bool {
        guard position.y < board.maxY && position.x < board.maxX else { return false }
        guard board.items.contains(where: { $0.position == position }) == false else {
            print("Failed to add item at position \(position), item already present")
            return false
        }
        return true
    }

    func replaceItem(item1: CCGameItem, with item2: CCGameItem) -> Bool {
        if removeItem(item1) == true {
            return addItem(item2)
        }
        return false
    }


    func produceEffect(_ move: GameItemMove) -> CCGameEffect? {
        // TODO check rules and board
        return nil
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

    func goToNextLevel() {

//        currentLevel+=1
//
//        let level = levels[currentLevel]

        //loadLevel(level)
    }

    func acceptMove(_ move: CCGameItemMove, from player: GamePlayer) {

        // if last move - save score per player, show message, load next level

        // if last level completed - save score per player, show scoreboard,
        
        // rules: [GameRule]
    }
    
    
    func makeMove(_ move: CCGameItemMove) {
        
    }
    

}


