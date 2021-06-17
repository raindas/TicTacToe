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
    
    // change speaker icon
    @State var soundOn = true
    
    @State var mainMenuButtonClicked = false
    @State var showMainMenuView = false
    //sheets
    @State var showAlert = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        GeometryReader {
            geometry in
            ZStack {
                BackgroundView()
                
                VStack {
                    
                    Text("high score : \(String(viewModel.winStatusView))")
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
                                            viewModel.processPlayerMove(for: i)
                                        }
                                    }
                                }
                            }.disabled(viewModel.isGameboardDisabled)
                            .padding()
                    }
                    
//                    Button(action: {}) { EmptyView() }
//                        .fullScreenCover(isPresented: $showMainMenuView, content: {
//                        ContentView()
//                    })
                    
                    NavigationLink("",destination:ContentView().navigationBarBackButtonHidden(true).navigationBarHidden(true),isActive: $showMainMenuView)
                    
                    Spacer()
                    
                    HStack {
                        
                        if soundOn {
                            Button(action: {soundOn.toggle()}, label: {
                                Image(systemName: "speaker.fill")
                            })
                        } else {
                            Button(action: {soundOn.toggle()}, label: {
                                Image(systemName: "speaker.slash.fill")
                            })
                        }
                        Spacer()
                        Image(systemName: "house.fill")
                        Spacer()
                        Image(systemName: "gearshape.fill")
                    }
                    .foregroundColor(gameColor.yellow)
                    .font(.system(size: 40.0))
                    .padding(.horizontal,30.0)
                    
                    
                }.fullScreenCover(isPresented: self.$viewModel.winStatusView, onDismiss: didDismiss, content: {
                    
                    if viewModel.newHighScoreView {
                        NewHighScoreView(highScore: viewModel.highScore, mainMenuButtonClicked: $mainMenuButtonClicked).environmentObject(self.viewModel)
                    } else {
                        GameWinStatusView(title: viewModel.winStatus, userScore: viewModel.playerScore, userSide: viewModel.getSide(player: "user"), botType: viewModel.gameDifficulty, botScore: viewModel.computerScore, botSide: viewModel.getSide(player: "bot"), mainMenuButtonClicked: $mainMenuButtonClicked).environmentObject(self.viewModel)
                    }
                    
                })
                .alert(isPresented: $showAlert, content: {
                    Alert(
                        title: Text("Proceed to main menu"),
                        message: Text("Current game will be ended, do you want to proceed?"),
                        primaryButton: .destructive(Text("Yes")) {
                            //print("yes selected")
                            viewModel.resetEntireGame()
                            showMainMenuView.toggle()
                            showAlert.toggle()
                            //self.presentationMode.wrappedValue.dismiss()
                        },
                        secondaryButton: .default(Text("No"))
                    )
                })
            }
        }
        
        
    }
    
    // the didDismiss function prevents the view from reconstructing with the view model's
    // status view variable set to true
    // hence, we set the view model's status view after the full screen presentation have been dismissed.
    func didDismiss() {
        if mainMenuButtonClicked {
            print("dismissed and main menu button clicked!")
            // ask the user if they really wanna end the game and proceed
            // to home page
            showAlert.toggle()
            //viewModel.statusView = false
            print(String(viewModel.winStatusView))
        } else {
            print("just dismissed!")
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().environmentObject(GameViewModel())
    }
}
