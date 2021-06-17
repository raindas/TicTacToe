//
//  BackgroundView.swift
//  TicTacToe
//
//  Created by President Raindas on 09/06/2021.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
