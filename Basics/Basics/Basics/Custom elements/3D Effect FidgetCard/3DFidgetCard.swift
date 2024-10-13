//
//  3DFidgetCard.swift
//  Basics
//
//  Created by Roman Golub on 13.10.2024.
//

import SwiftUI

struct FidgetCard: View {

    @State var dragLocation = CGPoint(x: 0, y: 0) // Coordinates of the drag gesture
    @State var isDragging = false

    var width: CGFloat = 340
    var height: CGFloat = 240

    var intensity: CGFloat = 10

    // Generic Linear Scale
    func scale(inputMin: CGFloat, inputMax: CGFloat, outputMin: CGFloat, outputMax: CGFloat, value: CGFloat) -> CGFloat {
        return outputMin + (outputMax - outputMin) * (value - inputMin) / (inputMax - inputMin)
    }

    var body: some View {
        ZStack {

            // Background
            Color(.black).ignoresSafeArea()

            // The Gradient Card
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(AngularGradient(gradient: Gradient(colors: [Color.red, Color.yellow, Color.green, Color.teal, Color.blue, Color.pink, Color.red]), center: .center))
                .frame(width: width, height: height)

            // The Drag Card
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(.black)
                .frame(width: width-14, height: height-14)
                .rotation3DEffect(.degrees(dragLocation.x), axis: (x: 0, y: 1, z: 0)) // Horizontal dragging tilts along Y Axis
                .rotation3DEffect(.degrees(dragLocation.y), axis: (x: 1, y: 0, z: 0)) // Vertical dragging tilts along X Axis
                .gesture(
                    DragGesture(minimumDistance: 0.0)
                        .onChanged { gesture in
                            let normalizedX = scale(inputMin: 0, inputMax: width - 4, outputMin: -intensity, outputMax: intensity, value: gesture.location.x)
                            let normalizedY = scale(inputMin: 0, inputMax: height - 4, outputMin: intensity, outputMax: -intensity, value: gesture.location.y)

                            print(normalizedX, normalizedY)

                            withAnimation(isDragging ? .interactiveSpring() : .spring()) {
                                dragLocation = CGPoint(x: normalizedX, y: normalizedY)
                            }
                            isDragging = true
                        }
                        .onEnded { _ in
                            isDragging = false
                            withAnimation(.spring()) {
                                dragLocation = .zero
                            }
                        }
                )
            
        }.statusBar(hidden: true)
        
    }
}

#Preview {
    FidgetCard()
}
