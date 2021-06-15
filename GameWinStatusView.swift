//
//  GameWinStatusView.swift
//  TicTacToe
//
//  Created by President Raindas on 14/06/2021.
//

import SwiftUI

struct GameWinStatusView: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    
    // local variables
    let title: String
    let userScore: Int
    let userSide: String
    let botType: String
    let botScore: Int
    let botSide: String
    
    // custom colors
    let gameColor = GameColor()
    
    // navigations
    @State var showHomeView = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
            
            VStack {
                
                Spacer()
                
                Text(title)
                    .font(.custom("ChocoCrunch", size: 30))
                    .foregroundColor(.white)
                Spacer()
                HStack {
                    
                    Spacer()
                    VStack {
                        Text("you")
                            .font(.custom("ChocoCrunch", size: 20))
                        Text(String(userScore))
                            .font(.custom("ChocoCrunch", size: 50))
                        Text(userSide)
                            .font(.custom("Maler", size: 40))
                            .foregroundColor(viewModel.getSideColor(indicator: userSide))
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
                        Text(botType)
                            .font(.custom("ChocoCrunch", size: 20))
                        Text(String(botScore))
                            .font(.custom("ChocoCrunch", size: 50))
                        Text(botSide)
                            .font(.custom("Maler", size: 40))
                            .foregroundColor(viewModel.getSideColor(indicator: botSide))
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
                
                Button(action: {
                    viewModel.resetGame()
                    self.presentationMode.wrappedValue.dismiss()
                    
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
                
                Button(action: {showHomeView.toggle()}, label: {
                    Text("main menu")
                        .font(.custom("ChocoCrunch", size: 20))
                        .padding(.vertical,10.5)
                        .padding(.horizontal,29.5)
                        .foregroundColor(.white)
                        .background(gameColor.orange)
                        .cornerRadius(9.0)
                }).fullScreenCover(isPresented: $showHomeView) {
                    ContentView()
                }
                
                Spacer()
                
            }.background(BackgroundBlurView()).edgesIgnoringSafeArea(.all)
    }
}

// background blur
struct BackgroundBlurView: UIViewRepresentable {
    //var effect: UIVisualEffect = UIBlurEffect(style: .systemThinMaterial)
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}

//struct BackgroundBlur_Previews: PreviewProvider {
//    static var previews: some View {
//        BackgroundBlurView()
//    }
//}

struct GameWinStatusView_Previews: PreviewProvider {
    static var previews: some View {
        GameWinStatusView(title: "you won", userScore: 5, userSide: "O", botType: "easy bot", botScore: 2, botSide: "X").environmentObject(GameViewModel())
    }
}
