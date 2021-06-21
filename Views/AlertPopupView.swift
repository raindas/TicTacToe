//
//  AlertPopupView.swift
//  TicTacToe
//
//  Created by President Raindas on 21/06/2021.
//

import SwiftUI

struct AlertPopupView: View {
    
    // custom colors
    let gameColor = GameColor()
    
    @EnvironmentObject var viewModel: GameViewModel
    // Audio manager
    @EnvironmentObject var audioManager: AudioManager
    
    @Binding var show: Bool
    @Binding var showMainMenuView: Bool
    @Binding var mainMenuButtonClicked: Bool
    
    var body: some View {
        ZStack {
            if show {
                Color.white.opacity(show ? 0.1 : 0).ignoresSafeArea()
                
                // popup window
                HStack {
                    VStack {
                        Text("Proceed to main menu")
                            .font(.custom("ChocoCrunch", size: 23))
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                        Text("Current game will be ended, do you want to proceed?")
                            .font(.custom("ChocoCrunch", size: 17))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                        HStack {
                            Spacer()
                            Button(action: {
                                withAnimation(.linear(duration: 0.3)) {
                                    viewModel.resetEntireGame()
                                    showMainMenuView.toggle()
                                    show.toggle()
                                }
                            }, label: {
                                Text("yes")
                                    .font(.custom("ChocoCrunch", size: 20))
                                    .padding(.vertical,10.5)
                                    .padding(.horizontal,29.5)
                                    .foregroundColor(.white)
                                    .background(gameColor.orange)
                                    .cornerRadius(15.0)
                            })
                            Spacer()
                            Button(action: {
                                withAnimation(.linear(duration: 0.3)) {
                                    mainMenuButtonClicked = false
                                    audioManager.playGamePlaySound()
                                    viewModel.resetGameRound()
                                    show.toggle()
                                }
                            }, label: {
                                Text("no")
                                    .font(.custom("ChocoCrunch", size: 20))
                                    .padding(.vertical,10.5)
                                    .padding(.horizontal,29.5)
                                    .foregroundColor(.white)
                                    .background(gameColor.pink)
                                    .cornerRadius(15.0)
                            })
                            Spacer()
                        }
                    }.padding(50)
                    .background(BackgroundBlurView())
                    .cornerRadius(25.0)
                }.padding()
            }
        }
    }
}

struct AlertPopupView_Previews: PreviewProvider {
    static var previews: some View {
        AlertPopupView(show: Binding.constant(true), showMainMenuView: Binding.constant(true), mainMenuButtonClicked: Binding.constant(true))
            .environmentObject(GameViewModel())
            .environmentObject(AudioManager())
    }
}
