//
//  ParallaxEffect.swift
//  Basics
//
//  Created by Roman Golub on 13.10.2024.
//

import SwiftUI
import CoreMotion
import CameraView

// You must add 2 keys in Basics Targets -> info -> Custom iOS target properties - Key
// add Privacy - Motion Usage Description and Privacy - Camera Usage Description
struct ParallaxEffect: View {
    @State var pitch: Double = 0.0
    @State var roll: Double = 0.0
    @State var yaw: Double = 0.0

    let manager = CMHeadphoneMotionManager()

    
    var body: some View {
        ZStack {
            VStack {
                Image("mountain")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 340, height: 500)
                    .scaleEffect(1.6)
                    .offset(x: CGFloat(yaw * 90), y: CGFloat(pitch * 90))
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .offset(x: CGFloat(-yaw * 5), y: CGFloat(-pitch * 5))
                    .animation(.linear(duration: 0.1), value: pitch)
                    .animation(.linear(duration: 0.1), value: yaw)

                ZStack {
                    CameraView(cameraPosition: .front)
                        .clipShape(Circle())
                        .frame(width: 180, height: 340)
                    
                }.frame(height: 220)
            }

        }.onAppear {
            manager.startDeviceMotionUpdates(to: .main) { (motionData, error) in
                pitch = motionData!.attitude.pitch
                roll = motionData!.attitude.roll
                yaw = motionData!.attitude.yaw
            }
        }
    }
}

#Preview {
    ParallaxEffect()
}
