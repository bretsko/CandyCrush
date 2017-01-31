//
//  Application.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/27/17.
//
//


final class Application {

    var name: String

    let gameLevelBuilder: GameLevelBuilder
    let gameBoardFactory: GameBoardFactory
    let minBoardSize = 2
    let maxBoardSize = 10

    init(name: String) {
        self.name = name
        self.gameLevelBuilder = GameLevelBuilder()
        self.gameBoardFactory = GameBoardFactory()
    }


    func run() {
        print("Welcome to \(name)!")

        let boardSize = askBoardSize()

        // fill randomly 50 % of board
        guard let board = gameBoardFactory.makeRandomSquareBoard2D(length: boardSize, percentsFilled: 50) else { return }

        let level1 = gameLevelBuilder.buildLevel1()

        let levels = [level1]

        // TODO: ask name
        let player = GamePlayer(name: "Player1")
        guard let game = CCGame(player: player, board: board, levels: levels) else { return }

        game.start()
    }

    func askBoardSize() -> Int {
        while(true){
            print("Please enter board size: ")
            if let boardSizeString = readLine() {
                if let boardSizeInt = stringToNumbers(boardSizeString, numberOfElements: 1), boardSizeInt[0] >= minBoardSize && boardSizeInt[0] <= maxBoardSize {
                    return boardSizeInt.first!
                } else {
                    print("Invalid board size, please enter number between \(minBoardSize) and \(maxBoardSize)")
                }
            }
        }
    }
    
}



