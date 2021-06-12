//
//  DifficultyView.swift
//  TicTacToe
//
//  Created by President Raindas on 09/06/2021.
//

import SwiftUI

struct DifficultyView: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    
    // custom colors
    private var gameColor = GameColor()
    
    // navigations
    @State private var showGameView = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack {
                
                BackgroundView()
                
                VStack {
                    
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(gameColor.yellow)
                                .font(.system(size: 40.0))
                        })
                        Spacer()
                        Text("select difficulty")
                            .font(.custom("ChocoCrunch", size: 24))
                            .foregroundColor(.white)
                        Spacer()
                    }.padding()
                    .padding(.top)
                    
                    
                    VStack {
                        
                        NavigationLink("",destination:GameView().navigationBarBackButtonHidden(true).navigationBarHidden(true),isActive: $showGameView)
                        Button(action: {
                            viewModel.gameDifficulty = "easy bot"
                            showGameView.toggle()
                        }, label: {
                            ZStack {
                                Image("pallete")
                                    .shadow(color: gameColor.shadow, radius: 20, x: 10.0, y: 10.0)
                                VStack {
                                    Image("easyBot")
                                        .resizable()
                                        .frame(width: 205.61, height: 205.61, alignment: .center)
                                    Text("easy bot")
                                        .font(.custom("ChocoCrunch", size: 24))
                                        .foregroundColor(.white)
                                }
                                
                            }
                        })
                        Spacer()
                        Button(action: {
                            viewModel.gameDifficulty = "hard bot"
                            showGameView.toggle()
                        }, label: {
                            ZStack {
                                Image("pallete")
                                    .shadow(color: gameColor.shadow, radius: 20, x: 10.0, y: 10.0)
                                VStack {
                                    Image("hardBot")
                                        .resizable()
                                        .frame(width: 205.61, height: 205.61, alignment: .center)
                                    Text("hard bot")
                                        .font(.custom("ChocoCrunch", size: 24))
                                        .foregroundColor(.white)
                                }
                                
                            }
                        })
                        
                        Spacer()
                    }
                    
                }.navigationBarHidden(true)
            }
        }
    }
}

struct DifficultyView_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyView()
    }
}
