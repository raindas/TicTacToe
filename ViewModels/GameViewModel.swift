//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by President Raindas on 10/06/2021.
//

import Foundation
import SwiftUI

final class GameViewModel: ObservableObject {
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible()),]
    
    // custom colors
    private var gameColor = GameColor()
    
    @Published var gameDifficulty = ""
    @Published var userSide = ""
    @Published var winStatus = ""
    
    // presentation views
    @Published var winStatusView = false
    @Published var newHighScoreView = false
    
    
    @Published var moves:[Move?] = Array(repeating: nil, count: 9)
    @Published var isGameboardDisabled = false
    @Published var playerScore = 0
    @Published var computerScore = 0
    @Published var highScore = 0
    //@Published var alertItem: AlertItem?
    
    func getSide(player:String) -> String {
        // check user type and return user side
        var side = "X"
        
        if player == "bot" {
            // set side as the opposite od user's side
            if userSide == "X" {
                side = "O"
            } else {
                side = "X"
            }
            
            return side
        }
        
        return userSide == side ? "X" : "O"
    }
    
    func getSideColor(indicator:String) -> Color {
        var color:Color
        if indicator == "X" {
            color = gameColor.orange
        } else {
            color = gameColor.yellow
        }
        return color
    }
    
    func setDifficulty(difficulty:String) {
        gameDifficulty = difficulty
    }
    
    func processPlayerMove(for position: Int) {
        //human move processing
        if isSquareOccupied(in: moves, forIndex: position) { return }
        
        if userSide == "X" {
            moves[position] = Move(player: .human, boardIndex: position, userSide: .xmark)
        } else {
            moves[position] = Move(player: .human, boardIndex: position, userSide: .circle)
        }
        
        // check for win condition or draw
        if checkWinCondition(for: .human, in: moves) {
            // alertItem = AlertContext.humanWin
            playerScore += 1
            if highScore < playerScore {
                highScore += 1
                newHighScoreView.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                winStatus = "you won"
                winStatusView.toggle()
                // resetGame()
            }
            
            return
        }
        
        
        if checkForDraw(in: moves) {
            // alertItem = AlertContext.draw
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                resetGameRound()
            }
            return
        }
        
        isGameboardDisabled = true
        
        // computer move processing
        // delay computer move for half a second
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            let computerPosition =  determineComputerMovePosition(difficulty: gameDifficulty, in: moves)
            
            if userSide == "X" {
                moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition, userSide: .xmark)
            } else {
                moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition, userSide: .circle)
            }
            
            isGameboardDisabled = false
            
            if checkWinCondition(for: .computer, in: moves) {
                // alertItem = AlertContext.computerWin
                computerScore += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                    //resetGame()
                    winStatus = "you lost"
                    winStatusView.toggle()
                }
                return
            }
            
            if checkForDraw(in: moves) {
                // alertItem = AlertContext.draw
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                    resetGameRound()
                }
                return
            }
        }
    }
    
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index})
    }
    
    // If AI can win, then win
    // If AI can't win, then block
    // If AI can't block, then take middle square
    // If AI can't take middle square, take random available square
    
    func determineComputerMovePosition(difficulty:String, in moves: [Move?]) -> Int {
        
        if difficulty == "easy bot" {
            // If AI can't take middle square, take random available square
            var movePosition = Int.random(in: 0..<9)
            
            while isSquareOccupied(in: moves, forIndex: movePosition) {
                movePosition = Int.random(in: 0..<9)
            }
            
            return movePosition
            
        }
        
        // If AI can win, then win
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
        let computerPositions = Set(computerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(computerPositions)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable { return winPositions.first!}
            }
        }
        
        // If AI can't win, then block
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human }
        let humanPositions = Set(humanMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(humanPositions)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable { return winPositions.first!}
            }
        }
        
        // If AI can't block, then take middle square
        let centerSquare = 4
        if !isSquareOccupied(in: moves, forIndex: 4) {
            return centerSquare
        }
        
        // If AI can't take middle square, take random available square
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
        
    }
    
    
    func determinePlayerColor(indicator:String) -> Color {
        var color:Color
        if indicator == "X" {
            color = gameColor.orange
        } else {
            color = gameColor.yellow
        }
        return color
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) {
            return true
        }
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        // if you remove all the nils and count equals to 9
        return moves.compactMap { $0 }.count == 9
    }
    
    func resetGameRound() {
        moves = Array(repeating: nil, count: 9)
    }
    
    func resetEntireGame() {
        // reset all game variables
        gameDifficulty = ""
        userSide = ""
        winStatus = ""
        playerScore = 0
        computerScore = 0
        
        // reset current game round
        resetGameRound()
        
        print("View Model reached, Game resetted!")
    }
}
