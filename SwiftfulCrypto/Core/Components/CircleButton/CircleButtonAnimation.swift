//
//  CircleButtonAnimation.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 03/02/25.
//

import SwiftUI

struct CircleButtonAnimation: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeOut(duration: 1.0) : nil)
    }
}

#Preview {
    CircleButtonAnimation(animate: .constant(false))
        .foregroundStyle(.red)
        .frame(width: 100, height: 100)
}
