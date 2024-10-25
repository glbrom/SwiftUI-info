//
//  Onboarding.swift
//  Basics
//
//  Created by Roman Golub on 25.10.2024.
//

import SwiftUI

struct OnBoarding: View {
    // MARK: - Properties
    @State private var currentStep = 1
    @State private var isMainTabViewActive = false
    @State private var dragOffset: CGFloat = 0
    
    private let itemWidth: CGFloat = 288
    private let peekAmount: CGFloat = 20
    private let dragThreshold: CGFloat = 0
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                // ImageCarousel
                ImageCarouselView(currentStep: $currentStep, dragOffset: $dragOffset, itemWidth: itemWidth, peekAmount: peekAmount, dragThreshold: dragThreshold)
                
                // PageIndicator
                PageIndicatorView(currentStep: $currentStep)
                    .padding(.bottom, 34)
                
                // TextContent
                TextContentView(currentStep: $currentStep)
                    .padding(.bottom, 64)
                
                // ActionButton
                ActionButtonView(buttonText: currentStep < 3 ? "Next" : "Get started") {
                    if currentStep < 3 {
                        withAnimation(.easeInOut) {
                            currentStep += 1
                        }
                    } else {
                        isMainTabViewActive = true
                    }
                }
                .padding(.bottom, 16)
                .fullScreenCover(isPresented: $isMainTabViewActive, content: {
                    // add view
                })
            }
        }
    }
}

#Preview {
    OnBoarding()
}
