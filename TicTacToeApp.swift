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
    @StateObject var audioManager = AudioManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(audioManager)
        }
    }
}
