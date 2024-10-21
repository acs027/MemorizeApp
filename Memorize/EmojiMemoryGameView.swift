//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by ali cihan on 13.10.2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    
    var body: some View {
        VStack {
            HStack {
                theme
                Spacer()
                newGame
            }
            cards
                .foregroundColor(viewModel.themeColor())
            HStack {
                score
                Spacer()
                shuffle
            }
            .font(.title)
        }
        .padding()
    }
    
    private var theme: some View {
        Text(viewModel.getTheme())
            .font(.title)
            .foregroundStyle(viewModel.themeColor())
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
    }
    
    private var newGame: some View {
        Button("New Game") {
            viewModel.newGame()
        }
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(spacing)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .onTapGesture {
                    withAnimation {
                        viewModel.choose(card)
                    }
                }
        }
    }
    
    private func scoreChange(causedBy card: Card) -> Int {
        return 0
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
