//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by ali cihan on 13.10.2024.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    @Published private var model: MemoryGame<String>
    private var theme: Theme
    
    init(theme: Theme) {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
        self.theme = theme
    }
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        var emojis = theme.emojis.uniqued.map(String.init)
        let numberOfPairs = min(theme.count, 8)
        return MemoryGame(numberOfPairs: numberOfPairs) { pairIndex in
            if let randomIndex = emojis.indices.randomElement() {
                return emojis.remove(at: randomIndex)
            } else {
                return "⁉️"
            }
        }
    }
    
    
    var score: Int {
        return model.score
    }
    
    var cards: Array<Card> {
        return model.cards
    }
    
    var themeColor: RGBA {
        theme.color
    }
    
    var themeName: String {
        theme.name
    }
    
    // MARK: Intents
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
        print(card.content, card.id)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}
