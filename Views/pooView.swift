//
//  pooView.swift
//  TicTacToe
//
//  Created by President Raindas on 17/06/2021.
//

import SwiftUI

struct pooView: View {
    
   // @State private var isPresenting = false
    
    @EnvironmentObject var viewModel: GameViewModel
    
    var body: some View {
        Button("Present FullScreen") {
            viewModel.statusView.toggle()
        }.fullScreenCover(isPresented: self.$viewModel.statusView, onDismiss: didDismiss, content: {
            VStack {
                Text("A full screen modal").font(.title)
                Button(action: {viewModel.statusView.toggle()}, label: {
                    Text("Tap to dismiss")
                })
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color.blue)
            .ignoresSafeArea(edges: .all)
        })
    }
    func didDismiss () {
        print("Something cool")
    }
}

struct pooView_Previews: PreviewProvider {
    static var previews: some View {
        pooView()
    }
}
