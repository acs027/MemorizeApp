//
//  CardVie.swift
//  Memorize
//
//  Created by ali cihan on 17.10.2024.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }

    var body: some View {
        TimelineView(.animation) { timeline in
            if card.isFaceUp || !card.isMatched {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .opacity(Constants.Pie.opacity)
                    .overlay(cardContents.padding(Constants.Pie.inset))
                    .padding(Constants.inset)
                    .cardify(isFaceUp: card.isFaceUp)
                    .transition(.scale)
            } else {
                Color.clear
            }
        }
    }
    
    var cardContents: some View {
        Text(card.content)
            .font(.system(size: Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scaleFactor)
            .multilineTextAlignment(.center)
            .aspectRatio(1, contentMode: .fit)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration: 1), value: card.isMatched)
    }
    
    private struct Constants {
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.5
            static let inset: CGFloat = 5
        }
    }
}

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: 1)
    }
}

#Preview {
    struct PreviewWrapper: View {
        typealias Card = MemoryGame<String>.Card
        var body: some View {
            VStack {
                HStack {
                    CardView(Card(isFaceUp: true, content: "X", id: "test1"))
                    CardView(Card(content: "X", id: "test1"))
                }
                
                HStack {
                    CardView(Card(isFaceUp: true, isMatched: true, content: "This is very long string and i hope it fits", id: "test1"))
                    CardView(Card(isMatched: true, content: "X", id: "test1"))
                }
            }
            .padding()
            .foregroundStyle(.green)
        }
    }
    
    return PreviewWrapper()
}
