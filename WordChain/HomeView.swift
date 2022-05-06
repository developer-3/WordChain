//
//  HomeView.swift
//  WordChain
//
//  Created by Adam Anderson on 5/2/22.
//

import SwiftUI

struct HomeView: View {
    @State private var isShowingGameView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("WordChain!")
                    .padding()
                    .font(.largeTitle)
                Spacer()
                NavigationLink(destination: GameView()) {
                    Text("Play")
                }
                .buttonStyle(PlayButton())
                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct PlayButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
