//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Michael Chapman on 5/8/24.
//

import SwiftUI

struct ContentView: View {
    private var moves = ["Scissors": "✂️", "Rock": "🪨", "Paper": "📄"]
    
    @State private var shouldWin: Bool
    @State private var cpuChoice: String
    @State private var score = 0
    
    init() {
        self.shouldWin = Bool.random()
        self.cpuChoice = moves.values.randomElement()!
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
                Text(cpuChoice).font(.system(size: 50))
                
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
                                Text(moves[key] ?? "Uh oh").font(.title)
                                Text(key).foregroundStyle(.black).font(.title3)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(.ultraThinMaterial)
                            .clipShape(.rect(cornerRadius: 20))
                        }
                    }
                }.padding()
                Spacer()
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
        }
        .font(.title.bold())
        .multilineTextAlignment(.center)
        .padding()
    }
}

#Preview {
    ContentView()
}
