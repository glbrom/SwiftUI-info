//
//  TextContentView.swift
//  Basics
//
//  Created by Roman Golub on 25.10.2024.
//

import SwiftUI

// MARK: - TextContentView
struct TextContentView: View {
    // MARK: - Properties
    @Binding var currentStep: Int
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text(currentStep < 2 ? "First to know" : " ")
                .font(.system(size: 24))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .frame(width: 216, alignment: .top)
            
            Text("All news in one place, be the first to know last news")
                .font(.system(size: 16))
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .frame(width: 216, alignment: .top)
                .padding(.top, 24)
        }
    }
}

#Preview {
    TextContentView(currentStep: .constant(3))
}

