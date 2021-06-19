//
//  NewHighScoreView.swift
//  TicTacToe
//
//  Created by President Raindas on 17/06/2021.
//

import SwiftUI

struct NewHighScoreView: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    
    // local variables
    let highScore: Int
    
    // custom colors
    let gameColor = GameColor()
    
    @Binding var mainMenuButtonClicked: Bool
    
    // navigations
    @State var showHomeView = false
    
    // Audio manager
    @EnvironmentObject var audioManager: AudioManager
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        ZStack {
            BackgroundBlurView()
            
            VStack {
                Image("confetti")
                    .resizable()
                
                Spacer()
                
                Group {
                    Text("new high score")
                    Text(String(highScore)).font(.custom("ChocoCrunch", size: 80))
                }.font(.custom("ChocoCrunch", size: 30))
                .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    viewModel.resetGameRound()
                    viewModel.winStatusView.toggle()
                    viewModel.newHighScoreView.toggle()
                }, label: {
                    Text("play next round")
                        .font(.custom("ChocoCrunch", size: 20))
                        .padding(.vertical,15.5)
                        .padding(.horizontal,20.5)
                        .foregroundColor(.white)
                        .background(gameColor.pink)
                        .cornerRadius(15.0)
                })
                
                Spacer()
                
                Button(action: {
                    mainMenuButtonClicked.toggle()
                    viewModel.winStatusView.toggle()
                    viewModel.newHighScoreView.toggle()
                }, label: {
                    Text("main menu")
                        .font(.custom("ChocoCrunch", size: 20))
                        .padding(.vertical,10.5)
                        .padding(.horizontal,29.5)
                        .foregroundColor(.white)
                        .background(gameColor.orange)
                        .cornerRadius(9.0)
                })
                
                
                Image("confetti")
                    .resizable()
                    .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0))
            }
            
        }.ignoresSafeArea()
        .onAppear {
            audioManager.playHighScoreSound()
        }
        
    }
}

struct NewHighScoreView_Previews: PreviewProvider {
    static var previews: some View {
        NewHighScoreView(highScore: 501, mainMenuButtonClicked: Binding.constant(false)).environmentObject(GameViewModel())
    }
}
