//
//  GameLogic.swift
//  WordChain
//
//  Created by Adam Anderson on 5/2/22.
//

import Foundation
import SwiftUI

class Game: ObservableObject {
    
    @Published var currentGuess = ["","","",""]
    
    var words = ["crab", "dome", "pump"]
    var currentWord = 0
    var currentTile = 1
    
    var letterList: [String] = []
    
    var timeLeft: Float = 30.0
    @Published var progress: Float = 1.0
    var additionalTime: Float = 5.0
    
    @Published var score = 0
    
    @Published var gameOver = false
    
    init() {
        loadWords()
        randomizeWord()
        startTimer()
    }
    
    func loadWords() {
        let path = Bundle.main.path(forResource: "words", ofType: "txt")!
        let text = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
        words = text.components(separatedBy: CharacterSet.newlines)
        
        currentWord = chooseWord()
    }
    
    func chooseWord() -> Int {
        let random = Int.random(in: 1..<words.count-1)
        return random
    }
    
    func chooseLetter(letter: String) {
        if (currentTile < 5) {
            currentGuess[currentTile-1] = letter
            currentTile += 1
        }
        if (currentTile == 5) {
            checkGuess()
        }
    }
    
    func checkGuess() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            let guess = self.currentGuess.joined()
            if (guess == self.words[self.currentWord]) {
                self.nextWord()
                self.timeLeft = min(self.timeLeft + self.additionalTime, 30.0)
                self.progress = self.timeLeft / 30.0
                self.score += 1
            }
            self.currentGuess = ["","","",""]
            self.currentTile = 1
        }
    }
    
    func randomizeWord() {
        letterList.removeAll()
        for i in words[currentWord] {
            letterList.append(String(i))
        }
        letterList.shuffle()
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.timeLeft -= 1

            self.progress = self.timeLeft / 30.0

            if(self.timeLeft==0){
                timer.invalidate()
                self.endGame()
            }
        }
    }
    
    func deleteLetter() {
        if (currentTile != 1) {
            currentGuess[currentTile - 2] = ""
            currentTile -= 1
        } else if (currentTile == 1) {
            currentGuess[currentTile - 1] = ""
        }
    }
    
    func endGame() {
        gameOver = true
    }
    
    func playAgain() {
        // TODO: Reset all values
        score = 0
        currentGuess = ["", "", "", ""]
        timeLeft = 30.0
        
        // TODO: Dismiss popup
        gameOver = false
        
        // TODO: start timer
        currentWord = chooseWord()
        randomizeWord()
        startTimer()
    }
    
    func getWord() -> String {
        return words[currentWord]
    }
    
    func getShuffled() -> [String] {
        return letterList
    }
    
    func nextWord() {
        currentWord = chooseWord()
        randomizeWord()
    }
}
