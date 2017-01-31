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

    var currentLevel: Int = 1
    var currentScore: Int = 0
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

    func start() {
        showWelcomeMessage()
        state = .started
        loop()
    }

    func loop() {
        while (state != .paused && state != .finished) {
            processUserInput()
            // check number of moves left - if 0 - lose
            // if win - show win message - next level
            // if move legal - process, next move
            // if move illegeal - show message, try again
        }
    }

    //TODO move to a separate class - cli
    func processUserInput() {

        printGameState()

        print("Make your move: ")

        func getSource() -> [Int] {
            while(true) {
                print("\nPlease enter source: ")

                if let moveString1 = readLine() {
                    if let moveInt1 = stringToNumbers(moveString1, numberOfElements: 2), moveInt1[0]  >= 0 && moveInt1[0] < self.board.maxX, moveInt1[1]  >= 0 && moveInt1[1] < self.board.maxY {

                        let pos = CCGameItemPosition2D(x: moveInt1[0], y: moveInt1[1])
                        if logic.isItemMovable(at: pos) {
                            return moveInt1
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
        func getDestination(with source: [Int]) -> [Int] {
            while(true) {
                print("Please enter destination: ")

                if let destString = readLine() {
                    if let destination = stringToNumbers(destString, numberOfElements: 2), destination[0]  >= 0 && destination[0] < self.board.maxX,
                        destination[1]  >= 0 && destination[1] < self.board.maxY {

                        let pos = CCGameItemPosition2D(x: destination[0], y: destination[1])
                        if logic.isItemMovable(at: pos) {
                            let pos1 = CCGameItemPosition2D(x: source[0], y: source[1])
                            let pos2 = CCGameItemPosition2D(x: destination[0], y: destination[1])
                            let move = CCGameItemMove(oldPosition: pos1, newPosition: pos2)

                            guard logic.checkMove(move) == true else { continue }

                            return destination
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

        let source: [Int] = getSource()
        let destination: [Int] = getDestination(with: source)

        let move = makeMove(x1: source[0], y1: source[1], x2: destination[0], y2: destination[1])
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

    // TODO move from here
    func makeMove(x1: Int, y1: Int, x2: Int, y2: Int) -> CCGameItemMove {
        let pos1 = CCGameItemPosition2D(x: x1, y: y1)
        let pos2 = CCGameItemPosition2D(x: x2, y: y2)
        let move = CCGameItemMove(oldPosition: pos1, newPosition: pos2)
        return move
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










