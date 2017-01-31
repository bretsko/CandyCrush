//
//  Application.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/27/17.
//
//

import Foundation

final class Application {

    var name: String

    let gameLevelBuilder: GameLevelBuilder
    let gameBoardFactory: GameBoardFactory

    init(name: String) {
        self.name = name
        self.gameLevelBuilder = GameLevelBuilder()
        self.gameBoardFactory = GameBoardFactory()
    }


    func run() {
        print("Welcome to Candy Crush!")

        let boardSize = askBoardSize()

        //fill 50 %
        guard let board = gameBoardFactory.makeRandomBoard2D(length: boardSize, percentsFilled: 50) else { return }

        let level1 = gameLevelBuilder.buildLevel1()

        let levels = [level1]

        //TODO ask name
        let player = GamePlayer(name: "Player1")
        guard let game = CCGame(player: player, board: board, levels: levels) else { return }

        game.start()
    }

    func askBoardSize() -> Int {
        while(true){
            print("Please enter board size: ")
            if let boardSizeString = readLine() {
                if let boardSizeInt = stringToNumbers(boardSizeString, numberOfElements: 1), boardSizeInt[0] > 1 && boardSizeInt[0] < 11 {
                    return boardSizeInt.first!
                } else {
                    print("Invalid board size, please enter number between 2 and 10")
                }
            }
        }
    }
    
}



