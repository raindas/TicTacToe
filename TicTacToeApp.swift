//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by President Raindas on 08/06/2021.
//

import SwiftUI

@main
struct TicTacToeApp: App {
    
    @StateObject var viewModel = GameViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
