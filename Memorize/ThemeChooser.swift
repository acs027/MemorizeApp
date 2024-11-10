//
//  ThemeChooser.swift
//  Memorize
//
//  Created by ali cihan on 6.11.2024.
//

import SwiftUI

struct ThemeChooser: View {
    @EnvironmentObject var store: ThemeStore
    @State private var showThemeEditor: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ThemeList()
                addNewThemeButton
            }
        }
        .sheet(isPresented: $showThemeEditor) {
            ThemeEditor(theme: $store.themes[store.cursorIndex])
        }
    }
    
    private var addNewThemeButton: some View {
        Button {
            addNewTheme()
            showThemeEditor = true
        } label: {
            Circle().frame(width: 50)
                .padding()
                .overlay {
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                }
        }
    }
    
    private func addNewTheme() {
        store.addNewTheme()
    }
}

#Preview {
    ThemeChooser()
        .environmentObject(ThemeStore(name: "Preview"))
}
