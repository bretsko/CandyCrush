//
//  Game.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/24/17.
//
//

import Foundation

enum GameState {
    case initial, started, finished
}

//current game played by a user
protocol Game {

    associatedtype GameLogic

    var state: GameState  { get set }

    var player: GamePlayer { get set }
    var board: CCGameBoard2D { get set }
    var levels: [GameLevel] { get set }
    var logic: GameLogic { get set }

    func start()
    func pause()
    func quit()
}

class CCGame: Game {

    typealias GameLogic = CCGameLevelLogic

    var player: GamePlayer
    var board: CCGameBoard2D
    var levels: [GameLevel]
    var state = GameState.initial

    //current logic for level
    var logic: GameLogic

    var currentLevel: Int = 0
    var movesLeft: Int

    init?(player: GamePlayer, board: CCGameBoard2D, levels: [GameLevel]) {

        guard levels.count > 0 else { return nil }

        self.player = player
        self.board = board
        self.levels = levels

        let firstLevel = levels.first!
        movesLeft = firstLevel.moves

        self.logic = CCGameLevelLogic(board:board, level: firstLevel)
    }

    //TODO move to a separate class - cli
    func start() {

        print("Starting game with \(board)")

        print("Make your move: ")

        while(true){

            var source: [Int]?
            while(true) {
                print("\nPlease enter source: ")

                if let moveString1 = readLine() {
                    if let moveInt1 = stringToNumbers(moveString1, numberOfElements: 2), moveInt1[0]  >= 0 && moveInt1[0] < self.board.maxX, moveInt1[1]  >= 0 && moveInt1[1] < self.board.maxY {

                        let pos = CCGameItemPosition2D(x: moveInt1[0], y: moveInt1[1])
                        if logic.isItemMovable(at: pos) {
                            source = moveInt1
                            break
                        } else {
                            print("No movable item at \(pos)")
                        }
                    } else {
                        print("Invalid move, please enter 2 numbers between 0 and \(self.board.maxX - 1)")
                        continue
                    }
                }
            }

            var destination: [Int]?
            while(true) {
                print("Please enter destination: ")

                if let moveString2 = readLine() {
                    if let moveInt2 = stringToNumbers(moveString2, numberOfElements: 2), moveInt2[0]  >= 0 && moveInt2[0] < self.board.maxX,
                        moveInt2[1]  >= 0 && moveInt2[1] < self.board.maxY {

                        let pos = CCGameItemPosition2D(x: moveInt2[0], y: moveInt2[1])
                        if logic.isItemMovable(at: pos) {
                            destination = moveInt2
                            if processMove(x1: source![0], y1: source![1], x2: destination![0], y2: destination![1]) == true {
                                break
                            }
                        } else {
                            print("No movable item at \(pos)")
                        }

                    } else {
                        print("Invalid move, please enter 2 numbers between 0 and \(self.board.maxX - 1)")
                        continue
                    }
                }
            }
        }
    }

    func processMove(x1: Int, y1: Int, x2: Int, y2: Int) -> Bool {
        let pos1 = CCGameItemPosition2D(x: x1, y: y1)
        let pos2 = CCGameItemPosition2D(x: x2, y: y2)
        let move = CCGameItemMove(oldPosition: pos1, newPosition: pos2)

        guard logic.checkMove(move) == true else { return false }

        if logic.makeMove(move) == true {
            print(board)
            return true
        } else {
            print("\nInvalid move!")
            return false
        }
    }


    func loadLevel(_ level: GameLevel) {
        // init counters - level, move

        let level = levels[currentLevel]

        let rules = level.rules

        self.logic =  CCGameLevelLogic(board:board, rules: rules)

        //movesLeft

    }


    func goToNextLevel() {

        currentLevel+=1

        let level = levels[currentLevel]

        //loadLevel(level)
    }

    func acceptMove(_ move: CCGameItemMove, from player: GamePlayer) {

        //if logic.validate

        movesLeft-=1

        // if first level - init counters, moves, gameBoard, GameLevellogic

        // if last move - save score per player, show message, load next level

        // if last level completed - save score per player, show scoreboard,

        // rules: [GameRule]
    }


    func makeMove(_ move: CCGameItemMove) {
        
    }
    
    
    func quit() {
        print("Come back soon!")
    }
    
    
    func pause() {
        
    }



}










