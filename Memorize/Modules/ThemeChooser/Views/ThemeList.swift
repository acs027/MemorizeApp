//
//  ThemeList.swift
//  Memorize
//
//  Created by ali cihan on 9.11.2024.
//

import SwiftUI

struct ThemeList: View {
    @EnvironmentObject var store: ThemeStore
    
    @State private var showThemeEditor: Bool = false
    
    @State private var emojiMemoryGames: [String : EmojiMemoryGame] = [:]
    
    var body: some View {
        List {
            ForEach(store.themes) { theme in
                rowView(theme: theme)
                    .swipeActions(edge: .leading) {
                        editButton(withThemeId: theme.id)
                    }
            }
            .onDelete { indexSet in
                withAnimation {
                    store.themes.remove(atOffsets: indexSet)
                }
            }
            .onMove { indexSet, newOffset in
                store.themes.move(fromOffsets: indexSet, toOffset: newOffset)
            }
        }
        .navigationDestination(for: Theme.ID.self) { themeId in
            if let index = store.themes.firstIndex(where: { $0.id == themeId }) {
                if let emojiMemoryGame = emojiMemoryGames[themeId.uuidString] {
                    EmojiMemoryGameView(viewModel: emojiMemoryGame)
                } else {
                    EmojiMemoryGameView(viewModel: createViewModel(withThemeId: themeId, index: index))
                }
            }
        }
        .sheet(isPresented: $showThemeEditor) {
            ThemeEditor(theme: $store.themes[store.cursorIndex])
        }
    }
    
    private func createViewModel(withThemeId id: Theme.ID, index: Int) -> EmojiMemoryGame {
        let viewModel = EmojiMemoryGame(theme: store.themes[index])
        emojiMemoryGames[id.uuidString] = viewModel
        return viewModel
    }
    
    private func rowView(theme: Theme) -> some View {
        return NavigationLink(value: theme.id) {
            VStack(alignment: .leading) {
                Text(theme.name)
                HStack {
                    Text("Color: ")
                    Rectangle().frame(width: 25, height: 25).foregroundStyle(Color(rgba: theme.color))
                    Spacer()
                    Text("Emoji count: \(theme.count)")
                }
                Text(theme.emojis)
                    .lineLimit(1)
            }
        }
    }
    
    private func editButton(withThemeId id: Theme.ID) -> some View {
        Button {
            store.setCursorIndex(withThemeId: id)
            showThemeEditor = true
        } label: {
            Label("Edit", systemImage: "plus.circle")
        }
    }
}

#Preview {
    ThemeList()
        .environmentObject(ThemeStore(name: "Preview"))
}
