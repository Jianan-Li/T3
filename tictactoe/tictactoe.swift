//
//  T3.swift
//  T3
//
//  Created by Jianan Li on 2/1/19.
//  Copyright © 2019 Jianan Li. All rights reserved.
//

import Foundation

struct T3: CustomStringConvertible {
    
    var description: String {
        get {
            // Initialize an empty string to be returned
            var gameState: String = ""
            
            for index in 0..<gameBoard.count {
                let cell = gameBoard[index]
                if cell != nil {
                    gameState.append(" \(cell!) ")
                } else {
                    gameState.append("   ")
                }
                if index % 3 == 0 || index % 3 == 1 {
                    gameState.append("|")
                }
                if index == 2 || index == 5 {
                    gameState.append("\n-----------\n")
                }
            }
            gameState.append("\n")
            
            if gameStatus == .over {
                gameState.append("\n\(gameResult!.rawValue)\n\n\n")
            }
            
            return gameState
        }
    }
    
    enum token: String {
        case X
        case O
    }
    
    enum status {
        case running
        case over
    }
    
    enum result: String {
        case draw = "It's a draw."
        case xWin = "X wins!"
        case oWin = "O wins!"
    }
    
    var gameBoard: [token?] = Array(repeating: nil, count: 9) {
        didSet {
            // Don't do anything if the didSet is triggered by a gameBoard reset
            if (gameBoard == Array(repeating: nil, count: 9)) {return}
            
            if (gameBoard[0] == gameBoard[1] && gameBoard[1] == gameBoard[2] && gameBoard[2] != nil) || (gameBoard[3] == gameBoard[4] && gameBoard[4] == gameBoard[5] && gameBoard[5] != nil) || (gameBoard[6] == gameBoard[7] && gameBoard[7] == gameBoard[8] && gameBoard[8] != nil) || (gameBoard[0] == gameBoard[3] && gameBoard[3] == gameBoard[6] && gameBoard[6] != nil) || (gameBoard[1] == gameBoard[4] && gameBoard[4] == gameBoard[7] && gameBoard[7] != nil) || (gameBoard[2] == gameBoard[5] && gameBoard[5] == gameBoard[8] && gameBoard[8] != nil) || (gameBoard[0] == gameBoard[4] && gameBoard[4] == gameBoard[8] && gameBoard[8] != nil) || (gameBoard[2] == gameBoard[4] && gameBoard[4] == gameBoard[6] && gameBoard[6] != nil) {
                // Winning condition met; reset game
                gameStatus = .over
                gameResult = tokenToBePlacedNext == .X ? .xWin : .oWin
            } else if (gameBoard[0] != nil && gameBoard[1] != nil && gameBoard[2] != nil
                && gameBoard[3] != nil && gameBoard[4] != nil && gameBoard[5] != nil
                && gameBoard[6] != nil && gameBoard[7] != nil && gameBoard[8] != nil ) {
                // Draw; reset game
                gameStatus = .over
                gameResult = .draw
            } else {
                // Winning condition not met; switch token
                switchToken()
            }
        }
    }
    
    var gameStatus: status = .running {
        didSet {
            gameIsOver = gameStatus == .over
            gameIsRunning = gameStatus != .over
        }
    }
    var gameIsRunning: Bool = true
    var gameIsOver: Bool = false
    
    var gameResult: result!
    
    var tokenToBePlacedNext: token
    
    init () {
        // Randomly initilize the first token to be placed
        tokenToBePlacedNext = (Int.random(in: 0..<2) == 0 ? token.X : token.O)
    }
    
    mutating func placeToken(at location: Int) {
        if location >= gameBoard.count {
            print("Illegal move: index out of range!\n")
        } else if gameBoard[location] != nil {
            print("Illegal move: cell is nonempty!\n")
        } else {
            gameBoard[location] = tokenToBePlacedNext
        }
    }
    
    mutating func switchToken() {
        switch(tokenToBePlacedNext) {
        case .O:
            tokenToBePlacedNext = .X
        case .X:
            tokenToBePlacedNext = .O
        }
    }
    
    mutating func resetGame() {
        gameBoard = Array(repeating: nil, count: 9)
        gameStatus = .running
        gameResult = nil
        tokenToBePlacedNext = (Int.random(in: 0..<2) == 0 ? token.X : token.O)
    }
    
    func printGameBoard() {
        for index in 0..<gameBoard.count {
            let cell = gameBoard[index]
            if cell != nil {
                print("\(cell!)", terminator:"\t")
            } else {
                print(cell as Any, terminator:"\t")
            }
            if index % 3 == 2 {
                print()
            }
        }
        print()
    }
}
