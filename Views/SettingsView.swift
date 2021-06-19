//
//  SettingsView.swift
//  TicTacToe
//
//  Created by President Raindas on 19/06/2021.
//

import SwiftUI

struct SettingsView: View {
    
    // view model
    @EnvironmentObject var viewModel: GameViewModel
    
    // custom colors
    let gameColor = GameColor()
    
    @State var showAlert = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            BackgroundBlurView().ignoresSafeArea()
            VStack {
                Spacer()
                Text("high score : \(viewModel.highScore)")
                    .font(.custom("ChocoCrunch", size: 30))
                    .foregroundColor(.white)
                Spacer()
                Button(action: {showAlert.toggle()}, label: {
                    Text("Reset high score")
                        .font(.custom("ChocoCrunch", size: 20))
                        .padding(.vertical,10.5)
                        .padding(.horizontal,29.5)
                        .foregroundColor(.white)
                        .background(gameColor.orange)
                        .cornerRadius(9.0)
                }).alert(isPresented: $showAlert, content: {
                    Alert(
                        title: Text("Are you sure?"),
                        message: Text("Your high score will be set back to the default value 0"),
                        primaryButton: .destructive(Text("Yes")) {
                            viewModel.resetHighScore()
                            self.presentationMode.wrappedValue.dismiss()
                        },
                        secondaryButton: .default(Text("No"))
                    )
                })
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(GameViewModel())
    }
}
