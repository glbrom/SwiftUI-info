//
//  BoomerangView.swift
//  Basics
//
//  Created by Roman Golub on 13.10.2024.
//

import SwiftUI

struct BoomerangView: View {
    @State private var topCard = 1
    
    var body: some View {
        ZStack {
            Card(color: Color.yellow, index: 4, topCard: $topCard)
            Card(color: Color.red, index: 3, topCard: $topCard)
            Card(color: Color.white, index: 2, topCard: $topCard)
            Card(color: Color.blue, index: 1, topCard: $topCard)
        }
        .preferredColorScheme(.dark)
        .statusBarHidden()
    }
}

#Preview {
    BoomerangView()
}
