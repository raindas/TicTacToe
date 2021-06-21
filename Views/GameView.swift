//
//  GameView.swift
//  TicTacToe
//
//  Created by President Raindas on 10/06/2021.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    
    // custom colors
    private var gameColor = GameColor()
    
    
    @State var mainMenuButtonClicked = false
    @State var showMainMenuView = false
    //sheets
    @State var showAlert = false
    
    // settings modal
    @State var settingsView = false
    
    @State var show = false
    
    // Audio manager
    @EnvironmentObject var audioManager: AudioManager
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        GeometryReader {
            geometry in
            ZStack {
                BackgroundView()
                
                VStack {
                    
                    Text("high score : \(String(viewModel.highScore))")
                        .font(.custom("ChocoCrunch", size: 20))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    HStack {
                        
                        Spacer()
                            VStack {
                                Text("you")
                                    .font(.custom("ChocoCrunch", size: 20))
                                Text(String(viewModel.playerScore))
                                    .font(.custom("ChocoCrunch", size: 50))
                                Text(viewModel.getSide(player: "user"))
                                    .font(.custom("Maler", size: 40))
                                    .foregroundColor(viewModel.getSideColor(indicator: viewModel.getSide(player: "user")))
                            }
                            .foregroundColor(.white)
                            .frame(width: 136, height: 172, alignment: .center)
                            .background(gameColor.palletpurple)
                            .cornerRadius(25.0)
                            .overlay(
                            RoundedRectangle(cornerRadius: 25.0)
                                .stroke(gameColor.steelblue, lineWidth: 2)
                            )
                        
                        Spacer()
                        
                        VStack {
                            Text(viewModel.gameDifficulty)
                                .font(.custom("ChocoCrunch", size: 20))
                            Text(String(viewModel.computerScore))
                                .font(.custom("ChocoCrunch", size: 50))
                            Text(viewModel.getSide(player: "bot"))
                                .font(.custom("Maler", size: 40))
                                .foregroundColor(viewModel.getSideColor(indicator: viewModel.getSide(player: "bot")))
                        }
                        .foregroundColor(.white)
                        .frame(width: 136, height: 172, alignment: .center)
                        .background(gameColor.palletpurple)
                        .cornerRadius(25.0)
                        .overlay(
                        RoundedRectangle(cornerRadius: 25.0)
                            .stroke(gameColor.steelblue, lineWidth: 2)
                        )
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(gameColor.palletpurple)
                            .frame(width: geometry.size.width - 10, height: geometry.size.width - 10)
                        
                            VStack {
                                LazyVGrid(columns: viewModel.columns, spacing: 5) {
                                    ForEach(0..<9) {
                                        i in
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 25.0)
                                                .fill(gameColor.gamepadpurple)
                                                .frame(width: geometry.size.width/3-15, height: geometry.size.width/3-15)
                                            
                                            Text(viewModel.moves[i]? .indicator ?? "")
                                                .font(.custom("Maler", size: 82))
                                                .foregroundColor(viewModel.determinePlayerColor(indicator: viewModel.moves[i]? .indicator ?? ""))
                                        }.onTapGesture {
                                            audioManager.playGameTapSound()
                                            viewModel.processPlayerMove(for: i)
                                        }
                                    }
                                }
                            }.disabled(viewModel.isGameboardDisabled)
                            .padding()
                    }.fullScreenCover(isPresented: self.$viewModel.winStatusView, onDismiss: didDismiss, content: {
                        
                        if viewModel.newHighScoreView {
                            NewHighScoreView(highScore: viewModel.highScore, mainMenuButtonClicked: $mainMenuButtonClicked).environmentObject(self.viewModel)
                        } else {
                            GameWinStatusView(title: viewModel.winStatus, userScore: viewModel.playerScore, userSide: viewModel.getSide(player: "user"), botType: viewModel.gameDifficulty, botScore: viewModel.computerScore, botSide: viewModel.getSide(player: "bot"), mainMenuButtonClicked: $mainMenuButtonClicked).environmentObject(self.viewModel)
                        }
                        
                    })
                    
                    NavigationLink("",destination:ContentView().navigationBarBackButtonHidden(true).navigationBarHidden(true),isActive: $showMainMenuView)
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            audioManager.stopSound()
                            audioManager.soundOn.toggle()
                        }, label: {
                            Image(systemName: audioManager.soundOn ? "speaker.fill" : "speaker.slash.fill")
                        })
                        Spacer()
                        Button(action: {
                            withAnimation(.linear(duration: 0.3)){
                                show.toggle()
                            }
                                //showAlert.toggle()
                            
                        }, label: {
                            Image(systemName: "house.fill")
                        })
                        Spacer()
                        Button(action: {settingsView.toggle()}, label: {
                            Image(systemName: "gearshape.fill")
                                .sheet(isPresented: $settingsView, content: {
                                    SettingsView()
                                })
                        })
                    }
                    .foregroundColor(gameColor.yellow)
                    .font(.system(size: 40.0))
                    .padding(.horizontal,30.0)
                    
                    
                }
            }
            
            AlertPopupView(show: $show, showMainMenuView: $showMainMenuView, mainMenuButtonClicked: $mainMenuButtonClicked)
        }.onAppear{
            //audioManager.stopBackgroundSound()
            audioManager.playGamePlaySound()
        }
        
        
    }
    
    // the didDismiss function prevents the view from reconstructing with the view model's
    // status view variable set to true
    // hence, we set the view model's status view after the full screen presentation have been dismissed.
    func didDismiss() {
        if mainMenuButtonClicked {
            //print("dismissed and main menu button clicked!")
            // ask the user if they really wanna end the game and proceed
            // to home page
            show.toggle()
            //viewModel.statusView = false
            //print(String(viewModel.winStatusView))
        } else {
            audioManager.playGamePlaySound()
            //print("just dismissed!")
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameViewModel())
            .environmentObject(AudioManager())
    }
}
