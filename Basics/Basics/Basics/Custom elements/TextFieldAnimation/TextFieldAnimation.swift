//
//  TextFieldAnimation.swift
//  Basics
//
//  Created by Roman Golub on 14.10.2024.
//

import SwiftUI

struct ExampleTextFieldAnimation: View {
    @State private var firstName = ""
    @State private var lastName = ""
    
    var body: some View {
        VStack {
            TextFieldAnimation(title: "First name", text: $firstName)
            TextFieldAnimation(title: "Last name", text: $lastName)
        }
        .padding()
    }
}

struct TextFieldAnimation: View {
    let title: String
    @Binding var text: String
    @FocusState var isTyping: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            TextField("", text: $text)
                .padding(.leading)
                .frame(height: 50)
                .focused($isTyping)
                .background(isTyping ? .black : Color.black)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isTyping ? .blue : Color.white, lineWidth: 2)
                )
            
            Text(title).padding(.horizontal, 4)
            //                .keyboardType(.numberPad)
                .background(.blue.opacity(isTyping || !text.isEmpty ? 1 : 0), in: RoundedRectangle(cornerRadius: 5))
                .foregroundStyle(isTyping ? .black : Color.white)
                .padding(.leading).offset(y: isTyping || !text.isEmpty ? -27 : 0)
                .onTapGesture {
                    isTyping.toggle()
                }
        }
        .animation(.linear(duration: 0.2), value: isTyping)
    }
}

#Preview {
    ExampleTextFieldAnimation()
}
