//
//  Square.swift
//  Minesweeper
//
//  Created by IHEB ISSAWI on 3/3/17.
//  Copyright © 2017 iheb.issawi. All rights reserved.
//

import UIKit

class Square {
    /**
     x position in board
     */
    var x:Int
    /**
     y position in board
     */
    var y:Int
    /**
     Nuber of mines in neighboring squares
    */
    var numberOfNeighboringMines :Int
    /**
     True if square is mine
    */
    var isMine = false
    /**
    True if square revealed
    */
    var isRevealed = false
    /**
    Inits the the square's coordinates
      - Parameter x:  position in board.
      - Parameter y:  position in board.
    */
    init(x:Int, y:Int) {
        self.x = x
        self.y = y
        numberOfNeighboringMines = 0
    }
    
}
