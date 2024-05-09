//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Michael Chapman on 5/8/24.
//

import SwiftUI

struct ContentView: View {
    private let winMap = ["Scissors": "Paper", "Paper": "Rock", "Rock": "Scissors"]
    private let moves = ["Scissors": "✂️", "Rock": "🪨", "Paper": "📄"]
        
    @State private var shouldWin: Bool
    @State private var cpuChoice: String
    @State private var score = 0
    @State private var answered = 0
    
    @State private var scoreAlertTitle = ""
    @State private var scoreAlertSubtitle = ""
    
    @State private var showScoreAlert = false
    @State private var showRestartAlert = false
    
    init() {
        self.shouldWin = Bool.random()
        self.cpuChoice = moves.keys.randomElement()!
    }
    
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            VStack {
                Spacer()
                // Title
                Text("Rock, paper, scissors?").font(.largeTitle).bold()
                Spacer()
                
                // Score
                Text("Score: \(score)").font(.title.bold())
                Spacer()
                
                // CPU move
                Text(moves[cpuChoice]!).font(.system(size: 50))
                Spacer()
                
                // Win/Lose
                // Play a winning move/Play a losing move
                // make winning green and losing red
                MovePrompt(isWinningMove: shouldWin)
                
                // Three buttons with moves in them + emojies
                HStack {
                    ForEach(moves.keys.sorted(), id: \.self) { key in
                        Button {
                            handlePlayerChoice(key)
                            handleNextMove()
                        } label: {
                            VStack {
                                Text(moves[key]!).font(.title)
                                Text(key).foregroundStyle(.black).font(.title3)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(.ultraThinMaterial)
                            .clipShape(.rect(cornerRadius: 20))
                        }
                        .alert(isPresented: $showScoreAlert) {
                            Alert(title: Text(scoreAlertTitle), message: Text(scoreAlertSubtitle), dismissButton: .default(Text("OK")))
                        }
                    }
                }.padding()
                Spacer()
            }
        }
    }
    
    func handlePlayerChoice(_ choice: String) {
        let shouldScore = (shouldWin && winMap[choice] == cpuChoice) || (!shouldWin && winMap[cpuChoice] == choice)
        // did what was asked
        if shouldScore {
            score += 1
            scoreAlertTitle = "Nice!"
            scoreAlertSubtitle = "Your score is \(score)"
        }
        // chose the same as the CPU or did opposite of what was asked
        else {
            scoreAlertTitle = "Try again..."
            scoreAlertSubtitle = "Your score is \(score)"
        }
        
        answered += 1
    }
    
    func handleNextMove() {
        if answered == 10 {
            showRestartAlert = true
        } else {
            showScoreAlert = true
        }
    }
}

struct MovePrompt: View {
    var isWinningMove: Bool
    var promptText: String { isWinningMove ? "winning" : "losing" }
    
    var body: some View {
        Group {
            Text("Play a ") + Text(promptText).foregroundStyle(isWinningMove ? .green : .red) + Text(" move against the move shown above")
        }
        .font(.title.bold())
        .multilineTextAlignment(.center)
        .padding()
    }
}

#Preview {
    ContentView()
}
