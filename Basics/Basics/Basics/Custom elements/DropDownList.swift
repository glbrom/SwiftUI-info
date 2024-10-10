//
//  DropDownMenu.swift
//  Basics
//
//  Created by Roman Golub on 10.10.2024.
//

import SwiftUI

struct DropDownList: View {
    
    @State private var mainTitle: String = "Timer"
    @State private var subTitle: String = "Duration"
    @State private var choosedDurationSec: String = ""
    
    @State private var showDropDownList: Bool = false
    @State private var timerToggle: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .ignoresSafeArea(.all)
                    .foregroundColor(.yellow)
                
                VStack {
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 30)
                                    .foregroundStyle(.white)
                                VStack {
                                    DisclosureGroupMenu
                                }
                            }
                            .padding(.top, 40)
                            .frame(width:348)
                        }
                    }
                    
                }
                .padding(.horizontal, 20)
            }
            .shadow(color: Color(red: 0.6, green: 0.62, blue: 0.76).opacity(0.3), radius: 15, x: 4, y: 4)
            .onDisappear {
                
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    
    // MARK: Body Drop menu DisclosureGroup
    var DisclosureGroupMenu: some View {
        VStack {
            ZStack { RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(Color.red)
                
                Toggle(isOn: $timerToggle.animation(.bouncy)) {
                    Text(mainTitle)
                        .font(.system(size: 20).bold())
                }
                .tint(Color.green)
                .padding(20)
            }
            .frame(width:308, height: 69)
            .padding(.top,20)
            .padding(.bottom,20)
            
            if timerToggle {
                ZStack() {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(Color.purple)
                        .frame(width: 308)
                    
                    VStack() {
                        
                        // DropDownList
                        DisclosureGroup( isExpanded: $showDropDownList) {
                            VStack(spacing: 0) {
                                // Divider if you want
                                Divider()
                                    .background(Color.black)
                                
                                // one item
                                Toggle(isOn: Binding(
                                    get: { choosedDurationSec == "30 sec" },
                                    set: { isOn in
                                        if isOn {
                                            choosedDurationSec = "30 sec"
                                        }
                                    })) {
                                        
                                        Text("30 sec")
                                            .padding(.trailing,210)
                                            .font(.system(size: 20))
                                            .frame(width:282, height: 40)
                                            .tint(.black)
                                    }
                                    .background(choosedDurationSec == "30 sec" ? Color.red : .clear)
                                    .toggleStyle(.button)
                                
                                // two item
                                Toggle(isOn: Binding(
                                    get: { choosedDurationSec == "60 sec" },
                                    set: { isOn in
                                        if isOn {
                                            choosedDurationSec = "60 sec"
                                        }
                                    })) {
                                        
                                        Text("60 sec")
                                            .padding(.trailing,210)
                                            .font(.system(size: 20))
                                            .frame(width:282, height: 40)
                                            .tint(.black)
                                    }
                                    .background(choosedDurationSec == "60 sec" ? Color.red : .clear)
                                    .toggleStyle(.button)
                                
                                // three item
                                Toggle(isOn: Binding(
                                    get: { choosedDurationSec == "120 sec" },
                                    set: { isOn in
                                        if isOn {
                                            choosedDurationSec = "120 sec"
                                        }
                                    })) {
                                        
                                        Text("120 sec")
                                            .padding(.trailing,210)
                                            .font(.system(size: 20))
                                            .frame(width:282, height: 40)
                                            .tint(.black)
                                    }
                                    .background(choosedDurationSec == "120 sec" ? Color.red : .clear)
                                    .toggleStyle(.button)
                                    .padding(.bottom, 25)
                            }
                        } label: {
                            // 2 section when main toggle on/off
                            HStack {
                                // subtitle
                                Text(subTitle)
                                    .font(.system(size: 20).bold())
                                    .tint(Color.black)
                                    .padding(.leading,20)
                                    .frame(height: 61)
                                Spacer()
                                // choose element list
                                Text(choosedDurationSec)
                                    .tint(Color.black)
                                    .font(.system(size: 20))
                            }
                            
                        }.accentColor(.clear)
                    }
                }
                .padding(.bottom, 20)
                .frame(width: 308)
            }
        }
    }
    
}


#Preview {
    DropDownList()
}
