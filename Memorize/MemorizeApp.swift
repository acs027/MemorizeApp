//
//  MemorizeApp.swift
//  Memorize
//
//  Created by ali cihan on 4.10.2024.
//

import SwiftUI

@main
struct MemorizeApp: App {
//    @StateObject var game = EmojiMemoryGame()
    @StateObject var themeStore = ThemeStore(name: "Main")
    
    var body: some Scene {
        WindowGroup {
//            EmojiMemoryGameView(viewModel: game)
            ThemeChooser()
                .environmentObject(themeStore)
        }
    }
}
