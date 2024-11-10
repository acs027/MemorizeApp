//
//  ThemeStore.swift
//  Memorize
//
//  Created by ali cihan on 6.11.2024.
//

import Foundation

extension UserDefaults {
    func themes(forKey key: String) -> [Theme] {
        if let jsonData = data(forKey: key),
           let decodedThemes = try? JSONDecoder().decode([Theme].self, from: jsonData) {
            return decodedThemes
        } else {
            return []
        }
    }
    
    func set(_ themes: [Theme], forKey key: String) {
        let data = try? JSONEncoder().encode(themes)
        set(data, forKey: key)
    }
}

class ThemeStore: ObservableObject {
    let name: String
    
    var id: String { name }
    
    private var userDefaultsKey: String { "ThemeStore:" + name }
    
    var themes: [Theme] {
        get {
            UserDefaults.standard.themes(forKey: userDefaultsKey)
        }
        set {
            if !newValue.isEmpty {
                UserDefaults.standard.set(newValue, forKey: userDefaultsKey)
                objectWillChange.send()
            }
        }
    }
    
    init(name: String) {
        self.name = name
        if themes.isEmpty {
            themes = Theme.builtins
        }
    }
    
    @Published var cursorIndex = 0
    
    func setCursorIndex(withThemeId id: Theme.ID) {
        if let index = themes.firstIndex(where: { $0.id == id }) {
            cursorIndex = index
        }
    }
    
    func addNewTheme() {
        themes.insert(Theme.newThemeTemplate, at: 0)
        cursorIndex = 0
    }
}
