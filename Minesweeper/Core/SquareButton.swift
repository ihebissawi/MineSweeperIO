//
//  SquareButton.swift
//  Minesweeper
//
//  Created by IHEB ISSAWI on 3/3/17.
//  Copyright © 2017 iheb.issawi. All rights reserved.
//

import UIKit

class SquareButton: UIButton {

  
    let squareSize:CGFloat
    let squareMargin:CGFloat
    var square:Square
    init(squareModel:Square, squareSize:CGFloat, squareMargin:CGFloat) {
        self.square = squareModel
        self.squareSize = squareSize
        self.squareMargin = squareMargin
        let x = CGFloat(self.square.x) * (squareSize + squareMargin)
        let y = CGFloat(self.square.y) * (squareSize + squareMargin)
        let squareFrame = CGRect(x:x, y:y, width:squareSize, height:squareSize)
        super.init(frame: squareFrame)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
