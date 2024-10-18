//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by ali cihan on 13.10.2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.getTheme())
                    .font(.title)
                    .foregroundStyle(viewModel.themeColor())
                Spacer()
                Text("Score: \(viewModel.score)")
            }
            cards
                .foregroundColor(viewModel.themeColor())
                .animation(.default, value: viewModel.cards)
            HStack {
                Button("Shuffle") {
                    viewModel.shuffle()
                }
                Button("New Game") {
                    viewModel.newGame()
                }
            }
        }
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(spacing)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
