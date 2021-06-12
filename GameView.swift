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
    
    
    var body: some View {
        GeometryReader {
            geometry in
            ZStack {
                BackgroundView()
                
                VStack {
                    
                    Text("high score : 500")
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
                    
                    Spacer()
                    
                }
            }
        }
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().environmentObject(GameViewModel())
    }
}
