//
//  ViewModifierExample.swift
//  Basics
//
//  Created by Roman Golub on 14.10.2024.
//

import SwiftUI

// MARK: - Custom modifiers
// v1
struct LargeBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
        // добавляем свойства которые нужно
            .font(.largeTitle.bold())
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
}

extension View {
    // largeBlueTitleStyle() - вызов модификатора через имя функции
    func largeBlueTitleStyle() -> some View {
        modifier(LargeBlueTitle())
    }
}

// v2
struct CustomTextModifier: ViewModifier {
    var backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(.thinMaterial)
            .background(backgroundColor)
            .cornerRadius(20)
            .shadow(color: .mint, radius: 5)
    }
}

extension View {
    func customTextStyle(backgroundColor: Color = .mint) -> some View {
        self.modifier(CustomTextModifier(backgroundColor: backgroundColor))
    }
}
