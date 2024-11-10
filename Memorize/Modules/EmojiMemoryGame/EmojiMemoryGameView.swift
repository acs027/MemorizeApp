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
    private let dealAnimation: Animation = .easeInOut(duration: 1)
    private let dealInterval: TimeInterval = 0.15
    private let deckWidth: CGFloat = 50
    
    var body: some View {
        VStack {
            cards.foregroundColor(Color(rgba: viewModel.themeColor))
            HStack {
                score
                Spacer()
//                deck.foregroundStyle(Color(rgba: viewModel.themeColor))
                Spacer()
//                shuffle
            }
            .font(.title)
        }
        .padding()
        .navigationTitle(viewModel.themeName)
        .toolbar {
            newGame
        }
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
//    private var shuffle: some View {
//        Button("Shuffle") {
//            withAnimation {
//                viewModel.shuffle()
//            }
//        }
//    }
    
    private var newGame: some View {
        Button("New Game") {
            viewModel.newGame()
        }
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
//            if isDealt(card) {
                CardView(card)
//                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
//            }
        }
    }
    
//    @State private var dealt = Set<Card.ID>()
//    
//    private func isDealt(_ card: Card) -> Bool {
//        dealt.contains(card.id)
//    }
//    private var undealtCards: [Card] {
//        viewModel.cards.filter { !isDealt($0) }
//    }
//    
//    @Namespace private var dealingNameSpace
//    
//    private var deck: some View {
//        ZStack {
//            ForEach(undealtCards) { card in
//                CardView(card)
//                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
//                    .transition(.asymmetric(insertion: .identity, removal: .identity))
//            }
//        }
//        .frame(width: deckWidth, height: deckWidth / aspectRatio)
//        .onTapGesture {
//            deal()
//        }
//    }
    
//    private func deal() {
//        var delay: TimeInterval = 0
//        for card in viewModel.cards {
//            withAnimation(dealAnimation.delay(delay)) {
//                _ = dealt.insert(card.id)
//            }
//            delay += dealInterval
//        }
//    }
    
    private func choose(_ card: Card) {
        withAnimation {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    
    @State private var lastScoreChange = (0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
}



#Preview {
    var theme = Theme.builtins.first!
    var emojiMemoryGame = EmojiMemoryGame(theme: theme)
    EmojiMemoryGameView(viewModel: emojiMemoryGame)
}