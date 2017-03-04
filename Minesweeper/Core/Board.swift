//
//  Board.swift
//  Minesweeper
//
//  Created by IHEB ISSAWI on 3/3/17.
//  Copyright © 2017 iheb.issawi. All rights reserved.
//

import UIKit

class Board: NSObject {
    
    var size:Int
    var difficulty: Int
    var squares:[[Square]]=[]
    
    var numberOfMines: Int = 0
    
     init(size:Int, difficulty:Int) {
        
        self.squares = []
        self.difficulty = difficulty
        self.size = size
        super.init()
        self.fillBoard()
        
        
    }
    /**
     It fills the board with a square modul after affecting the isMine property .
     */
    func fillBoard(){
        for  i in (0..<size){
            var squareRow:[Square]=[]
            for  j in (0..<size){
                squareRow.append(self.fillSquare(x:i, y:j))
            }
            squares.append(squareRow)
        }
        VerifyNumberOfMines()
        
        
        

    }
    /**
     It fills a square with a probability of being a mince according to a difficulty given.
     */
    func fillSquare(x: Int, y: Int) -> Square
    {
        let square = Square(x: x, y: y)

        if(numberOfMines<((size*size*difficulty)/100)){
            square.isMine = Int(arc4random_uniform(99))<(difficulty)
            if(square.isMine){
                numberOfMines += 1
            }
        }
        return square
    }
    /**
     It verifies  the number of mines.
     */
    func VerifyNumberOfMines()
    {
        while(numberOfMines<(size*size*difficulty)/100){
            
            for  i in (0..<size){
                for  j in (0..<size){
                    if(!(squares[i][j]).isMine){
                        squares[i][j] = (self.fillSquare(x:i, y:j))
                    }
                }
            }

            
        }
    
    }
    
    /**
     It calculates  the number of the neighboring mines.
     
     ## Important Notes ##
     1. Both parameters are **int** numbers.
     - Parameter x: position of the square on the x line.
     - Parameter y: position of the square on the y line.
     */
    func CalculateNeighboringMines(x: Int, y: Int)
    {
        for  i in ((x-1)..<x+2){
            for  j in ((y-1)..<y+2){
                if(squares.indices.contains(i))
                {
                    if(squares[i].indices.contains(j))
                    {
                        //print("Square[",i,",",j,"]")
                        if(squares[i][j].isMine)
                        {
                            //print("Square[",i,",",j,"] is Mine")
                            (squares[x][y]).numberOfNeighboringMines += 1

                        }
                    }
                }
                
            }
        }

    }
    
    /**
     attributes a color based on the accurance of number of mines to a single square.
     */
    func SetNumbercolor(numberOfNeighboringMines : Int)->UIColor {
        switch (numberOfNeighboringMines) {
        case 1:
            return UIColor(red: 0, green: 204/255, blue: 0, alpha: 1)
        case 2:
            return UIColor(red: 128/255, green: 255/255, blue: 0, alpha: 1)
        case 3:
            return UIColor(red: 153/255, green: 51/255, blue: 255/255, alpha: 1)
        case 4:
            return UIColor(red: 204/255, green: 0, blue: 204/255, alpha: 1)
        case 5:
            return UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        case 6:
            return UIColor(red: 255/255, green: 0, blue: 0, alpha: 1)
        case 7:
            return UIColor(red: 204/255, green: 0, blue: 0, alpha: 1)
        case 8:
            return UIColor(red: 102/255, green: 0, blue: 0, alpha: 1)
        default:
            return UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        }
    }


}
