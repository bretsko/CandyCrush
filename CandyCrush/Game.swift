//
//  Game.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/24/17.
//
//


enum GameState {
    case initial, started, paused, finished
}

protocol Game {

    associatedtype Logic: GameLogic
    typealias Board = Logic.GLBoard

    var logic: Logic { get set }
    var board: Board { get set }
    var state: GameState  { get set }
    var player: GamePlayer { get set }
    var levels: [GameLevel] { get set }

    func start()
    func pause()
    func quit()
}

class Game2D: Game {

    typealias Logic = GameLogic2D
    typealias Board = Logic.GLBoard
    typealias GameItem = Board.GameBoardItem
    typealias GIType = GameItem.GIType
    typealias GIPosition = GameItem.GIPosition

    typealias GIMove = CCGameItemMove<GIPosition>

    var player: GamePlayer
    var board: Board
    var levels: [GameLevel]
    var logic: Logic
    var state = GameState.initial

    var currentLevel: Int = 1
    var currentScore: Int = 0
    var movesLeft: Int

    init?(board: Board, player: GamePlayer, levels: [GameLevel]) {

        guard levels.count > 0 else { return nil }

        self.board = board
        self.player = player
        self.levels = levels

        let firstLevel = levels.first!
        movesLeft = firstLevel.moves

        self.logic = Logic(board: board, level: firstLevel)
    }

    func start() {
        showWelcomeMessage()
        state = .started
        loop()
    }

    func loop() {
        while (state != .paused && state != .finished) {
            processUserInput()
            // check number of moves left - if 0 - lose
            // if win - show win message - next leveln
        }
    }

    //TODO move to a separate class - cli
    func processUserInput() {

        printGameState()

        print("Make your move: ")

        func getSource() -> GIPosition {
            while(true) {
                print("\nPlease enter source: ")

                if let moveString1 = readLine() {
                    if let moveInt1 = stringToNumbers(moveString1, numberOfElements: 2), moveInt1[0]  >= 0 && moveInt1[0] < self.board.maxX, moveInt1[1]  >= 0 && moveInt1[1] < self.board.maxY {

                        let pos = GIPosition(x: moveInt1[0], y: moveInt1[1])
                        if logic.isItemMovable(at: pos) {
                            return pos
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

        //TODO return GamePosition
        func getDestination(with source: GIPosition) -> GIPosition {
            while(true) {
                print("Please enter destination: ")

                if let destString = readLine() {
                    if let destination = stringToNumbers(destString, numberOfElements: 2), destination[0]  >= 0 && destination[0] < self.board.maxX,
                        destination[1]  >= 0 && destination[1] < self.board.maxY {

                        let pos = GIPosition(x: destination[0], y: destination[1])
                        if logic.isItemMovable(at: pos) {
                            let pos1 = GIPosition(x: source.x, y: source.y)
                            let pos2 = GIPosition(x: destination[0], y: destination[1])
                            let move = GIMove(source: pos1, destination: pos2)

                            guard logic.checkMove(move) == true else { continue }

                            return pos
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

        let source = getSource()
        let destination = getDestination(with: source)

        let move = GIMove(source: source, destination: destination)
        logic.processMove(move)

        //check score and moves - go to next level if reached high score
        movesLeft-=1

        if logic.nextLevelReached() || movesLeft == 0 {
            //TODO: go to next level
            if currentLevel < levels.count {
                currentLevel+=1
                self.logic.load(level: levels[currentLevel])
            } else {
                //TODO: game finish
            }
        }
    }

    func printGameState() {
        print("\n Level: \(currentLevel)\n Moves: \(movesLeft)\n Score: \(currentScore)\n" )
        print(board)
    }

    func showWelcomeMessage() {
        print("Starting game")
    }

    func quit() {
        print("Come back soon!")
    }

    func pause() {
        print("Pause")
    }

}










