//
//  ImageCarouselView.swift
//  Basics
//
//  Created by Roman Golub on 25.10.2024.
//

import SwiftUI

struct ImageMock: Identifiable {
    var id = UUID()
    var image: String
}

private let imageMock: [ImageMock] = [
    ImageMock(image: "1"),
    ImageMock(image: "2"),
    ImageMock(image: "1"),
    ImageMock(image: "2")
]

// MARK: - ImageCarouselView
struct ImageCarouselView: View {
    // MARK: - Properties
    @Binding var currentStep: Int
    @Binding var dragOffset: CGFloat
    
    let itemWidth: CGFloat
    let peekAmount: CGFloat
    let dragThreshold: CGFloat
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: peekAmount - 2) {
                ForEach(0..<imageMock.count) { item in
                    VStack {
                        Image(imageMock[item].image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: itemWidth, height: 336)
                            .cornerRadius(12)
                            .padding(.top, 76)
                            .scaleEffect(self.scaleValueForItem(at: item, in: geometry))
                    }
                }
                .offset(x: calculateOffset() + dragOffset + 56)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.interactiveSpring()) {
                                dragOffset = value.translation.width
                            }
                        }
                        .onEnded { value in
                            withAnimation(.interactiveSpring()) {
                                finalizePosition(dragValue: value)
                                dragOffset = 0
                            }
                        }
                )
            }
        }
    }
    
    // MARK: - Methods
    // Function for calculating offset
    func calculateOffset() -> CGFloat {
        let totalWidth = itemWidth + peekAmount
        let baseOffset = -CGFloat(currentStep) * totalWidth
        return baseOffset
    }
    
    // Scale the current element
    func scaleValueForItem(at index: Int, in geometry: GeometryProxy) -> CGFloat {
        let currentItemOffset = calculateOffset() + dragOffset
        let itemPosition = CGFloat(index) * (itemWidth + peekAmount) + currentItemOffset
        let distanceFromCenter = abs(geometry.size.width / 2.7 - itemPosition - itemWidth / 2)
        let scale: CGFloat = 1 + (0.2 * (0.32 - min(1, distanceFromCenter / (itemWidth + peekAmount))))
        return scale
    }
    
    // Finish scrolling
    func finalizePosition(dragValue: DragGesture.Value) {
        if dragValue.predictedEndTranslation.width > dragThreshold && currentStep > 1 {
            currentStep -= 1
        } else if dragValue.predictedEndTranslation.width < -dragThreshold && currentStep < imageMock.count - 1 {
            currentStep += 1
        }
    }
}
