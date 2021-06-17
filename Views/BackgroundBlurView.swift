//
//  BackgroundBlurView.swift
//  TicTacToe
//
//  Created by President Raindas on 17/06/2021.
//

import SwiftUI

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

struct BackgroundBlur_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundBlurView()
    }
}
