//
//  PickASideView.swift
//  TicTacToe
//
//  Created by President Raindas on 09/06/2021.
//

import SwiftUI

struct PickASideView: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    
    // custom colors
    private var gameColor = GameColor()
    
    // change speaker icon
    @State var soundOn = true
    
    // navigations
    @State private var showDifficultyView = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack {
                
                BackgroundView()
                
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(gameColor.yellow)
                                .font(.system(size: 40.0))
                        })
                        Spacer()
                        Text("pick a side")
                            .font(.custom("ChocoCrunch", size: 24))
                            .foregroundColor(.white)
                        Spacer()
                    }.padding()
                    .padding(.top)
                    
                    VStack {
                        NavigationLink(
                            "",
                            destination:DifficultyView().navigationBarBackButtonHidden(true).navigationBarHidden(true),
                            isActive: $showDifficultyView
                        )
                        Button(action: {
                            viewModel.userSide = "X"
                            showDifficultyView.toggle()
                        }, label: {
                            ZStack {
                                Image("pallete")
                                    .shadow(color: gameColor.shadow, radius: 20, x: 10.0, y: 10.0)
                                Text("X")
                                    .font(.custom("Maler", size: 300))
                                    .foregroundColor(gameColor.orange)
                            }
                        })
                        Button(action: {
                            viewModel.userSide = "O"
                            showDifficultyView.toggle()
                        }, label: {
                            ZStack {
                                Image("pallete")
                                    .shadow(color: gameColor.shadow, radius: 20, x: 10.0, y: 10.0)
                                Text("O")
                                    .font(.custom("Maler", size: 300))
                                    .foregroundColor(gameColor.yellow)
                            }
                        })
                        
                        Spacer()
                    }
                    
                }
                
            }.navigationBarHidden(true)
            
        }
        
    }
}

struct PickASideView_Previews: PreviewProvider {
    static var previews: some View {
        PickASideView()
    }
}
