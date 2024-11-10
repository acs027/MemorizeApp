//
//  ThemeEditor.swift
//  Memorize
//
//  Created by ali cihan on 6.11.2024.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme
    
    @State private var selectedColor: Color = .white
    private let emojiFont = Font.system(size: 40)
    
    @State private var emojisToAdd: String = ""
    
    enum Focused {
        case name, emoji
    }
    
    @FocusState private var focused: Focused?
    
    private var gameEmojiCount: Int {
        max(theme.emojis.uniqued.count, 2)
    }
    
    var body: some View {
        Form {
            nameSection
            colorSection
            gameEmojiPairs
            addEmojis
            removeEmojis
            reAddEmojis
        }
        .onAppear {
            selectedColor = Color(rgba: theme.color)
        }
        .onDisappear {
            theme.color = RGBA(color: selectedColor)
        }
    }
    
    private var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $theme.name)
                .focused($focused, equals: .name)
        }
    }
    
    private var colorSection: some View {
        Section(header: Text("Color")) {
            HStack {
                Text("Color: ")
                ColorPicker(selection: $selectedColor) { }
            }
        }
    }
    
    private var gameEmojiPairs: some View {
        Section("Game Emoji Pair"){
            Stepper("Count: \(theme.count)", value: $theme.count, in: 2...gameEmojiCount, step: 1)
        }
    }
    
    private var addEmojis: some View {
        Section(header: Text("Emojis")) {
        TextField("Add emojis here", text: $emojisToAdd)
            .focused($focused, equals: .emoji)
            .onChange(of: emojisToAdd) {
                theme.emojis = (emojisToAdd + theme.emojis)
                    .filter { $0.isEmoji }
                    .uniqued
            }
        }
    }
    
    private var removeEmojis: some View {
        VStack(alignment: .trailing) {
            Text("Tap to Remove Emojis").font(.caption).foregroundStyle(.gray)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(theme.emojis.uniqued.map(String.init), id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            removeEmoji(emoji: emoji)
                        }
                }
            }
        }
        .font(emojiFont)
    }
    
    @ViewBuilder
    private var reAddEmojis: some View {
        if !theme.removedEmojis.isEmpty {
            Section {
                VStack(alignment: .trailing) {
                    Text("Tap to recover Emojis").font(.caption).foregroundStyle(.gray)
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                        ForEach(theme.removedEmojis.uniqued.map(String.init), id: \.self) { emoji in
                            Text(emoji)
                                .onTapGesture {
                                    recoverEmoji(emoji: emoji)
                                }
                        }
                    }
                }
                .font(emojiFont)
            }
        }
    }
    
    private func removeEmoji(emoji: String) {
        withAnimation {
            theme.emojis.remove(emoji.first!)
            emojisToAdd.remove(emoji.first!)
            theme.removedEmojis = (theme.removedEmojis + emoji).filter { $0.isEmoji }
                .uniqued
        }
    }
    
    private func recoverEmoji(emoji: String) {
        withAnimation {
            theme.emojis = (theme.emojis + emoji)
                .filter { $0.isEmoji }
                .uniqued
            theme.removedEmojis.remove(emoji.first!)
        }
    }
}

#Preview {
    ThemeEditor_Preview()
}

struct ThemeEditor_Preview: View {
    @State private var theme = ThemeStore(name: "Preview").themes.first!
    var body: some View {
        ThemeEditor(theme: $theme)
    }
}
