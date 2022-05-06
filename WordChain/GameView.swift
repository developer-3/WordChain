//
//  Game.swift
//  WordChain
//
//  Created by Adam Anderson on 5/2/22.
//

import SwiftUI

struct GameView: View {
    
    @StateObject var game = Game()
    
    @State var guessFillColor = Color.clear
    
    @State var showEndView = false
    
    var body: some View {
        ZStack {
            Color.yellow
                .opacity(0.1)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("\(game.score)")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                Spacer()
                HStack {
                    ForEach(0..<4) { i in
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(Color.blue, lineWidth: 5)
                            .background(game.currentGuess[i] == "" ? RoundedRectangle(cornerRadius: 15).foregroundColor(Color.clear) : RoundedRectangle(cornerRadius: 15).foregroundColor(Color.blue))
                            .frame(width: 75, height: 75)
                            .overlay(
                                Text(game.currentGuess[i])
                                    .font(.system(size: 50, weight: .bold))
                            )
                    }
                }
                Spacer()
                ZStack {
                    ProgressBar(progress: $game.progress)
                            .frame(width: 300.0, height: 300.0)
                            .padding(40.0)
                    VStack {
                        Circle()
                            .strokeBorder(Color.black, lineWidth: 0)
                            .background(Circle().fill(Color.blue))
                            .frame(width: 75, height: 75)
                            .overlay(
                                Button("\(game.getShuffled()[0])", action: {
                                    game.chooseLetter(letter: game.getShuffled()[0])
                                })
                                    .font(.system(size: 50, weight: .bold))
                                    .foregroundColor(.white)
                            )

                        HStack {
                            Spacer()
                            Spacer()
                            Circle()
                                .strokeBorder(Color.black, lineWidth: 0)
                                .background(Circle().fill(Color.blue))
                                .frame(width: 75, height: 75)
                                .overlay(
                                    Button("\(game.getShuffled()[1])", action: {
                                        game.chooseLetter(letter: game.getShuffled()[1])
                                    })
                                        .font(.system(size: 50, weight: .bold))
                                        .foregroundColor(.white)
                                )
                            Spacer()
                            Button(action: {
                                game.deleteLetter()
                            }) {
                                Image(systemName: "delete.left.fill")
                                    .font(.system(size: 30.0))
                                    .opacity(0.5)
                            }
                            Spacer()
                            Circle()
                                .strokeBorder(Color.black, lineWidth: 0)
                                .background(Circle().fill(Color.blue))
                                .frame(width: 75, height: 75)
                                .overlay(
                                    Button("\(game.getShuffled()[2])", action: {
                                        game.chooseLetter(letter: game.getShuffled()[2])
                                    })
                                        .font(.system(size: 50, weight: .bold))
                                        .foregroundColor(.white)
                                )
                            Spacer()
                            Spacer()
                        }
                        Circle()
                            .strokeBorder(Color.black, lineWidth: 0)
                            .background(Circle().fill(Color.blue))
                            .frame(width: 75, height: 75)
                            .overlay(
                                Button("\(game.getShuffled()[3])", action: {
                                    game.chooseLetter(letter: game.getShuffled()[3])
                                })
                                    .font(.system(size: 50, weight: .bold))
                                    .foregroundColor(.white)
                            )
                    }
                }
                Spacer()
            }
            
            if (game.gameOver) {
                EndView().environmentObject(game)
            }
        }
    }
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

struct ProgressBar: View {
    @Binding var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.red)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.red)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
        }
    }
}

struct EndView: View {
    
    @EnvironmentObject private var game: Game
    
    var body: some View {
        ZStack {
            Color.white
                .opacity(1.0)
                .frame(width: 300, height: 600, alignment: .center)
            VStack {
                Spacer()
                Text("Game Over!")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                Spacer()
                Text("You scored: \(game.score)")
                    .font(.system(size: 40, weight: .semibold, design: .rounded))
                    .foregroundColor(.black)
                Text("You missed the word: **\(game.getWord())**")
                Spacer()
                Button("Play Again!", action: {
                    game.playAgain()
                }).clipShape(Capsule())
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                Spacer()
            }
        }.clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
