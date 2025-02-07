//
//  ContentView.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 03/02/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack (spacing: 30) {
                Text("Accent Color")
                    .foregroundStyle(Color.theme.accentColor)
                
                Text("Green Color")
                    .foregroundStyle(Color.theme.greenColor)
                
                Text("Red Color")
                    .foregroundStyle(Color.theme.redColor)
                
                Text("Secondary Text Color")
                    .foregroundStyle(Color.theme.secondaryTextColor)
            }
        }
    }
}

#Preview {
    ContentView()
}
