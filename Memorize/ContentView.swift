////
////  EmojiMemoryGameView.swift
////  Memorize
////
////  Created by ali cihan on 4.10.2024.
////
//
//import SwiftUI
//
//struct Dummy: View {
//    let defaultEmojis = ["😄", "😃", "😀", "😁", "😀", "😃", "😄", "😁",]
//    let vehicleEmojis = ["🚗", "🚛", "🚒", "🚓", "🚔", "🚖", "🚙", "🚗", "🚛", "🚒", "🚓", "🚔", "🚖", "🚙",]
//    let sportEmojis = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏊‍♀️", "🏌️", "🏄‍♀️", "⚽️", "🏀", "🏈", "⚾️", "🎾", "🏊‍♀️", "🏌️", "🏄‍♀️",]
//    @State var emojis = [ "😀", "😃", "😄", "😁", "😀", "😃", "😄", "😁",]
//    @State var cardCount: Int = 4
//    
//    var body: some View {
//        VStack {
//            Text("Memorize!")
//                .font(.largeTitle)
//            ScrollView {
//                cards
//            }
//            Spacer()
//            themeAdjusters
////            Spacer()
////            cardCountAdjusters
//        }
//        .padding()
//    }
//    
//    var themeAdjusters: some View {
//        HStack(spacing: 20) {
//            defaultTheme
////            Spacer()
//            hallowenTheme
////            Spacer()
//            newYearTheme
//        }
//        .padding()
//    }
//    
//    func themeAdjuster(theme: String, symbol: String) -> some View {
//        Button {
//            switch theme {
//                case "vehicle":
//                emojis = vehicleEmojis
//            case "sport":
//                emojis = sportEmojis
//            default:
//                emojis = defaultEmojis
//            }
//            emojis.shuffle()
//        } label: {
//            VStack {
//                Image(systemName: symbol)
//                    .imageScale(.large)
//                Text(theme.capitalized)
//            }
//            .font(.title3)
//        }
//    }
//    
//    var defaultTheme: some View {
//        themeAdjuster(theme: "default", symbol: "smiley")
//    }
//    
//    var hallowenTheme: some View {
//        themeAdjuster(theme: "vehicle", symbol: "car.fill")
//    }
//    
//    var newYearTheme: some View {
//        themeAdjuster(theme: "sport", symbol: "basketball.circle.fill")
//    }
//    
//    var cards: some View {
//        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
//            ForEach(0..<cardCount, id: \.self) { index in
//                CardView(content: emojis[index])
//                    .aspectRatio(2/3, contentMode: .fit)
//            }
//            .foregroundStyle(.orange)
//        }
//    }
//    
//    var cardCountAdjusters: some View {
//        HStack {
//            cardRemover
//            Spacer()
//            cardAdder
//        }
//        .imageScale(.large)
//        .font(.largeTitle)
//    }
//    
//    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
//        Button {
//            cardCount += offset
//        } label: {
//            Image(systemName: symbol)
//        }
//        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
//    }
//    
//    var cardRemover: some View {
//        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
//        
//    }
//    
//    var cardAdder: some View {
//        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
//    }
//}
//
//struct nView: View {
//    let content: String
//    @State var isFaceUp = false
//    
//    var body: some View {
//        ZStack {
//            let base = RoundedRectangle(cornerRadius: 12)
//            Group {
//                base.fill(.white)
//                base.strokeBorder(lineWidth: 2)
//                Text(content).font(.largeTitle)
//            }
//            .opacity(isFaceUp ? 1 : 0)
//            base.fill().opacity(isFaceUp ? 0 : 1)
//        }
//        .onTapGesture {
//            isFaceUp.toggle()
//        }
//    }
//}
//
//#Preview {
//    EmojiMemoryGameView()
//}
