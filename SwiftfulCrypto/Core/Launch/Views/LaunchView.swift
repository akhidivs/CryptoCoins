//
//  LaunchView.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 07/02/25.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var showLoadingText: Bool = false
    @State private var counter: Int  = 0
    @State private var loopCount: Int = 0
    @Binding var showLaunchView: Bool
    
    private let loadingText: [String] = "Loading your portfolio...".map { String($0) }
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.launchTheme.launchBackgroundColor
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .resizable()
                .frame(width: 120, height: 120)
                .ignoresSafeArea()
            
            ZStack {
                
                if showLoadingText {
                    HStack(spacing: 0) {
                        
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .foregroundStyle(Color.launchTheme.launchAccentColor)
                                .font(.headline)
                                .fontWeight(.heavy)
                                .offset(y: counter == index ? -5 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(Animation.easeIn))
                }
            }
            .offset(y: 70)
        }
        .onAppear {
            showLoadingText.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                if (counter == loadingText.count - 1) {
                    counter = 0
                    loopCount += 1
                    if loopCount > 1 {
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        }
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
}
