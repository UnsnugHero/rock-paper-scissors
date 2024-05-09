//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Michael Chapman on 5/8/24.
//

import SwiftUI

struct ContentView: View {
    private var moves = ["Scissors": "✂️", "Rock": "🪨", "Paper": "📄"]
    
    @State private var shouldWin = false
    @State private var cpuChoice = ""
    @State private var score = 0
    
    var body: some View {
        // Title
        Text("Rock, paper, scissors?").font(.title)
        
        // Score
        Text("Score: \(score)")
        
        // CPU move
        
        // Win/Lose
        // Play a winning move/Play a losing move
        // make winning green and losing red
        MovePrompt(isWinningMove: shouldWin)
        
        // Three buttons with moves in them + emojies
        HStack {
            ForEach(moves.keys.sorted(), id: \.self) { key in
                Button {
                    print("Clicked \(key)")
                } label: {
                    VStack {
                        Text(moves[key] ?? "Uh oh")
                        Text(key)
                    }
                    .padding()
                    .background(.red)
                }
            }
        }
    }
}

struct MovePrompt: View {
    var isWinningMove: Bool
    var promptText: String { isWinningMove ? "winning" : "losing" }
    
    var body: some View {
        Group {
            Text("Play a ") + Text(promptText).foregroundStyle(isWinningMove ? .green : .red) + Text(" move against the above move")
        }.font(.title2).multilineTextAlignment(.center)
    }
}

#Preview {
    ContentView()
}
