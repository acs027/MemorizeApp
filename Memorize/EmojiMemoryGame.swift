//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by ali cihan on 13.10.2024.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static var theme = "default" {
        willSet {
            switch newValue {
            case "vehicle":
                emojis = vehicleEmojis
            case "sport":
                emojis = sportEmojis
            case "animal":
                emojis = animalEmojis
            case "food":
                emojis = foodEmojis
            case "nature":
                emojis = natureEmojis
            case "face":
                emojis = facesEmojis
            default:
                emojis = defaultEmojis
            }
        }
    }
    
    private var themes = ["default", "vehicle", "sport", "animal", "food", "nature", "face"]
    
    private static var emojis = defaultEmojis
    
    
    static let vehicleEmojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚜"]
    static let sportEmojis = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸"]
    static let animalEmojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯"]
    static let foodEmojis = ["🍎", "🍌", "🍇", "🍓", "🍒", "🍉", "🍍", "🍑", "🥝", "🍆"]
    static let natureEmojis = ["🌲", "🌳", "🌴", "🌵", "🌿", "☘️", "🌻", "🌼", "🌷", "🍂"]
    static let facesEmojis = ["😀", "😂", "😍", "😎", "😡", "😭", "🥳", "😱", "😴", "🤯"]
    private static let defaultEmojis = ["💕", "💠", "🪿", "🐣", "🦀", "🍉", "🦋", "🌪️", "🍒","🐝"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairs: 2) { pairIndex in
            if let randomIndex = emojis.indices.randomElement() {
                return emojis.remove(at: randomIndex)
            } else {
                return "⁉️"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var score: Int {
        return model.score
    }
    
    var cards: Array<Card> {
        return model.cards
    }
    
    // MARK: Intents
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func getTheme() -> String {
        return EmojiMemoryGame.theme.capitalized
    }
    
    func themeColor() -> Color {
        switch EmojiMemoryGame.theme {
        case "vehicle":
            return .red
        case "sport":
            return .blue
        case "animal":
            return .brown
        case "food":
            return .orange
        case "nature":
            return .green
        case "face":
            return .yellow
        default:
            return .gray
        }
    }
    
    func newGame() {
        if let randomTheme = themes.randomElement() {
            EmojiMemoryGame.theme = randomTheme
        }
        model = EmojiMemoryGame.createMemoryGame()
        shuffle()
    }
}
