//
//  Theme.swift
//  Memorize
//
//  Created by ali cihan on 6.11.2024.
//

import Foundation


struct Theme: Identifiable, Codable {
    var name: String
    var emojis: String
    var id = UUID()
    var color: RGBA
    var count = 2
    var removedEmojis : String = ""
    
    static var newThemeTemplate: Theme {
        Theme(name: "", emojis: "", color: RGBA(red: 1/255, green: 1/255, blue: 1/255, alpha: 1))
    }
    
    static var builtins: [Theme] {
        [
            Theme(name: "Vehicles", emojis: "🚙🚗🚘🚕🚖🏎🚚🛻🚛🚐🚓🚔🚑🚒🚀✈️🛫🛬🛩🚁🛸🚲🏍🛶⛵️🚤🛥🛳⛴🚢🚂🚝🚅🚆🚊🚉🚇🛺🚜", color: RGBA(red: 1/255, green: 1/255, blue: 75/255, alpha: 1)),
            Theme(name: "Sports", emojis: "🏈⚾️🏀⚽️🎾🏐🥏🏓⛳️🥅🥌🏂⛷🎳", color: RGBA(red: 200/255, green: 1/255, blue: 75/255, alpha: 1)),
            Theme(name: "Music", emojis: "🎼🎤🎹🪘🥁🎺🪗🪕🎻", color: RGBA(red: 200/255, green: 1/255, blue: 75/255, alpha: 1)),
            Theme(name: "Animals", emojis: "🐥🐣🐂🐄🐎🐖🐏🐑🦙🐐🐓🐁🐀🐒🦆🦅🦉🦇🐢🐍🦎🦖🦕🐅🐆🦓🦍🦧🦣🐘🦛🦏🐪🐫🦒🦘🦬🐃🦙🐐🦌🐕🐩🦮🐈🦤🦢🦩🕊🦝🦨🦡🦫🦦🦥🐿🦔", color: RGBA(red: 200/255, green: 1/255, blue: 75/255, alpha: 1)),
            Theme(name: "Animal Faces", emojis: "🐵🙈🙊🙉🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐷🐸🐲", color: RGBA(red: 200/255, green: 1/255, blue: 75/255, alpha: 1)),
            Theme(name: "Flora", emojis: "🌲🌴🌿☘️🍀🍁🍄🌾💐🌷🌹🥀🌺🌸🌼🌻", color: RGBA(red: 200/255, green: 1/255, blue: 75/255, alpha: 1)),
            Theme(name: "Weather", emojis: "☀️🌤⛅️🌥☁️🌦🌧⛈🌩🌨❄️💨☔️💧💦🌊☂️🌫🌪", color: RGBA(red: 200/255, green: 1/255, blue: 75/255, alpha: 1)),
            Theme(name: "COVID", emojis: "💉🦠😷🤧🤒", color: RGBA(red: 200/255, green: 1/255, blue: 75/255, alpha: 1)),
            Theme(name: "Faces", emojis: "😀😃😄😁😆😅😂🤣🥲☺️😊😇🙂🙃😉😌😍🥰😘😗😙😚😋😛😝😜🤪🤨🧐🤓😎🥸🤩🥳😏😞😔😟😕🙁☹️😣😖😫😩🥺😢😭😤😠😡🤯😳🥶😥😓🤗🤔🤭🤫🤥😬🙄😯😧🥱😴🤮😷🤧🤒🤠", color: RGBA(red: 200/255, green: 1/255, blue: 75/255, alpha: 1))
        ]
    }
}
