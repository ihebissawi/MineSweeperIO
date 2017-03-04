//
//  MainViewController.swift
//  Minesweeper
//
//  Created by IHEB ISSAWI on 3/3/17.
//  Copyright © 2017 iheb.issawi. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var boardUIView: UIView!
    /**
     squareSize the square size
     */
    var squareSize:CGFloat=0
    /**
     difficulty of the game
     */
    var difficulty:Int=10
    /**
     size of the board
     */
    var size:Int = 5
    
    var board:Board?
    /**
     number Of Revealed Squares
     */
    var numberOfRevealedSquares=0
    /**
     number mines
     */
    var numberOfMines=0
    
    var squareButtons:[SquareButton] = []
    var gameDidEnd:Bool=false

    @IBOutlet weak var timeLabel: UILabel!
    var seconds=0
    var timer=Timer()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        loadgame()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /**
     loades the game .
     */
    func loadgame()
    {
        
        
        self.runTimer()

        difficulty = size*3
        board = Board(size:size, difficulty:difficulty)
        
        squareSize=(boardUIView.frame.height)/CGFloat(size)
        
        
        
        for  i in (0..<size){
            for  j in (0..<size){
                let square = board!.squares[i][j]
                let squareSize:CGFloat = self.boardUIView.frame.width / CGFloat(size)
                let squareButton = SquareButton(squareModel: square, squareSize: squareSize, squareMargin: 1);
                
               
                squareButton.setBackgroundImage(#imageLiteral(resourceName: "squareHidden.png"), for: .normal)
                
                
                
                
                if(squareButton.square.isMine){
                    numberOfMines += 1
                }
                
                
                let tapGesture = UITapGestureRecognizer(target: self, action:#selector( SquareTapped))
                tapGesture.numberOfTapsRequired = 2
                
                squareButton.addGestureRecognizer(tapGesture)
                
                
                squareButton.addTarget(self, action:#selector( SquareClicked), for: .touchUpInside)
                self.boardUIView.addSubview(squareButton)
                squareButtons.append(squareButton)
            }
        }
        

    }
    
    
    func restartGame(){
        numberOfMines = 0
        numberOfRevealedSquares = 0
        numberOfMines = 0
        Resettimer()
        gameDidEnd = false
        
        squareButtons.forEach { (squareButton) in
            squareButton.removeFromSuperview()
        }
        
        loadgame()
    
    }
    
    func SquareClicked(sender:SquareButton){
        if((!sender.square.isRevealed)&&(!gameDidEnd)&&(sender.imageView?.image != #imageLiteral(resourceName: "flag.png")))
        {
            sender.setBackgroundImage(#imageLiteral(resourceName: "square.png"), for: .normal)

            sender.square.isRevealed = true
  
            if(sender.square.isMine){
                sender.setImage(#imageLiteral(resourceName: "bomb.png"), for: .normal)
                gameEnded(didWin:false)
                numberOfRevealedSquares=0

            }else{
                numberOfRevealedSquares+=1

                board!.CalculateNeighboringMines(x: sender.square.x, y: sender.square.y)
                sender.setTitleColor(board!.SetNumbercolor(numberOfNeighboringMines: sender.square.numberOfNeighboringMines), for: .normal)
                sender.setTitle("\(sender.square.numberOfNeighboringMines)", for: .normal)
                
                var numberOfNoMines = ((size*size)*(100-difficulty))/100
                if((((size*size)*(100-difficulty))%100) != 0){
                    numberOfNoMines += 1
                }
                

                
                if(numberOfRevealedSquares>=numberOfNoMines)
                {
                    gameEnded(didWin:true)
                }
                
            }
            

        }
       
    }
    func SquareTapped(sender: UITapGestureRecognizer)
    {
        if(!gameDidEnd){
            let squareBtn = sender.view as! SquareButton
            if(!squareBtn.square.isRevealed)
            {
                if(squareBtn.imageView?.image == #imageLiteral(resourceName: "flag.png"))
                {
                    squareBtn.setImage(UIImage(), for: .normal)
                    
                }else{
                    squareBtn.setImage(#imageLiteral(resourceName: "flag.png"), for: .normal)
                }
            }
        }
    }
    
    func gameEnded(didWin: Bool){
        gameDidEnd = true
         timer.invalidate()
        if(didWin){
           /* let alertViewController = self.storyboard?.instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
            alertViewController.mainVc = self
            self.present(alertViewController, animated: true, completion: nil)*/
            let alert = UIAlertController(title: title, message: "you completed the game in \(timeLabel.text)", preferredStyle:.actionSheet)
            let ok = UIAlertAction(title: "Restart", style: .default) { action in
                self.restartGame()
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            
        }else{
            revealMines()
            /*
            let alertViewController = self.storyboard?.instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
            alertViewController.mainVc = self
            self.present(alertViewController, animated: true, completion: nil)
           */
            let alert = UIAlertController(title: title, message:"you loose", preferredStyle:.actionSheet)
            let ok = UIAlertAction(title: "Restart", style: .default) { action in
                self.restartGame()
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    func revealMines(){
        squareButtons.forEach { element in
            
            if(element.square.isMine){
                element.setBackgroundImage(#imageLiteral(resourceName: "square.png"), for: .normal)
                element.setImage(#imageLiteral(resourceName: "bomb.png"), for: .normal)
                numberOfMines += 1
            }
            
            
        }
        
    }
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(MainViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    func updateTimer() {
        seconds += 1
        timeLabel.text = timeString(time: TimeInterval(seconds))
    }
   func Resettimer() {
        timer.invalidate()
        seconds = 0    //Here we manually enter the restarting point for the seconds, but it would be wiser to make this a variable or constant.
        timeLabel.text = "\(seconds)"
    }
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    @IBAction func helpbtn(_ sender: Any) {
        Resettimer()
        let firstUseViewController = self.storyboard?.instantiateViewController(withIdentifier: "FirstUseViewController") as! FirstUseViewController
        
        self.present(firstUseViewController, animated: true, completion: nil)
    }
  
    @IBAction func restartBtn(_ sender: Any) {
        
            self.restartGame()
    }
    @IBAction func homeBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
