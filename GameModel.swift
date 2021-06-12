//
//  GameModel.swift
//  TicTacToe
//
//  Created by President Raindas on 10/06/2021.
//

import Foundation

enum Player {
    case human, computer
}

enum PlayerSide {
    case xmark, circle
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    let userSide: PlayerSide
    
    var side: String {
        return userSide == .xmark ? "X" : "O"
    }
    
    var indicator: String {
        if side == "X" {
            return player == .human ? "X" : "O"
        } else {
            return player == .human ? "O" : "X"
        }
    }
    
    //static let poo = Move(player: <#Player#>, boardIndex: <#Int#>)
}
//
//struct Difficulty {
//    var difficulty: String
//}
