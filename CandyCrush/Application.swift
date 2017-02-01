//
//  Application.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/27/17.
//
//


final class Application {

    var name: String

    typealias CCGame = Game2D
    typealias Logic = Game2D.Logic
    typealias GIMove = Game2D.GIMove

    typealias GameItem = Game2D.GameItem
    typealias GIType = GameItem.GIType
    typealias GIPosition = GameItem.GIPosition
    typealias Board = Game2D.Board

    //let gameLevelBuilder: CCGameLevelBuilder
    let gameBoardFactory: GameBoard2DFactory
    let minBoardSize = 2
    let maxBoardSize = 10

    init(name: String) {
        self.name = name
        //self.gameLevelBuilder = GameLevelBuilder()
        self.gameBoardFactory = GameBoard2DFactory()
    }


    func run() {
        print("Welcome to \(name)!")

        let boardSize = askBoardSize()

        // fill randomly 50 % of board
        guard let board = gameBoardFactory.makeRandomBoard(length: boardSize, percentsFilled: 50) else { return }

       // let level1 = gameLevelBuilder.buildLevel1()

        let levels = [CCGameLevel]()

        // TODO: ask name
        let player = GamePlayer(name: "Player1")
        guard let game = CCGame(board: board, player: player, levels: levels) else { return }

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



