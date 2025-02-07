//
//  Color.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 03/02/25.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
    static let launchTheme = LaunchTheme()
}

struct ColorTheme {
    
    let accentColor = Color("MyAccent")
    let backgroundColor = Color("MyBackground")
    let greenColor = Color("MyGreen")
    let redColor = Color("MyRed")
    let secondaryTextColor = Color("MySecondaryText")
}

struct LaunchTheme {
    
    let launchAccentColor = Color("LaunchAccentColor")
    let launchBackgroundColor = Color("LaunchBackgroundColor")
}
