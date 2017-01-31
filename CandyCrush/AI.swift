//
//  AI.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 1/27/17.
//
//

import Foundation

final class AI : GamePlayer {

    init(){
        super.init(name: "AI")
    }


    override func makeMove() {
        // TODO: 
    }

    func proposeMove() -> CCGameItemPosition2D {
        // TODO: calculate coordinates
        return CCGameItemPosition2D(x: 0, y: 0)
    }
}
