//
//  ContentView.swift
//  TicTacToe
//
//  Created by President Raindas on 08/06/2021.
//

import SwiftUI
import AVKit

struct ContentView: View {
    // view model
    @EnvironmentObject var viewModel: GameViewModel
    
    // Audio manager
    @EnvironmentObject var audioManager: AudioManager
    
    // custom colors
    let GamePink = Color.init(red: 212/255, green: 172/255, blue: 195/255, opacity: 1.0)
    let GameYellow = Color.init(red: 238/255, green: 199/255, blue: 71/255, opacity: 1.0)
    
    // settings modal
    @State var settingsView = false
    
    // navigate to pick a side
    @State private var showPickASideView = false
    
    
    var body: some View {
        NavigationView {
            ZStack {
                
                BackgroundView()
                
                VStack {
                    
                    Spacer()
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 315.05, height: 378.37, alignment: .center)
                    
                    Spacer()
                    
                    Text("High Score : \(viewModel.highScore)")
                        .font(.custom("ChocoCrunch", size: 20))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    NavigationLink("",destination:PickASideView().navigationBarBackButtonHidden(true).navigationBarHidden(true),isActive: $showPickASideView)
                    Button(action: {
                        showPickASideView.toggle()
                    }, label: {
                        Text("start")
                            .font(.custom("ChocoCrunch", size: 55))
                            .padding(.vertical,3.5)
                            .padding(.horizontal,94.5)
                            .foregroundColor(.white)
                            .background(GamePink)
                            .cornerRadius(25.0)
                            .frame(width: 354, height: 98, alignment: .center)
                    })
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            audioManager.stopSound()
                            audioManager.soundOn.toggle()
                        }, label: {
                            Image(systemName: audioManager.soundOn ? "speaker.fill" : "speaker.slash.fill")
                        })
                        Spacer()
                        Button(action: {settingsView.toggle()}, label: {
                            Image(systemName: "gearshape.fill")
                                .sheet(isPresented: $settingsView, content: {
                                    SettingsView()
                                })
                        })
                    }
                    .foregroundColor(GameYellow)
                    .font(.system(size: 40.0))
                    .padding(.horizontal,30.0)
                    
                }
            }.navigationBarHidden(true)
        }.onAppear{
            audioManager.playBackgroundSound()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GameViewModel())
            .environmentObject(AudioManager())
    }
}
