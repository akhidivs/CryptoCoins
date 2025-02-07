//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 03/02/25.
//

import SwiftUI

@main
struct SwiftfulCryptoApp: App {
    
    @StateObject var homeVM = HomeViewModel()
    @State private var showLaunchView: Bool = true
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accentColor)]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accentColor)]
        UINavigationBar.appearance().tintColor = UIColor(Color.theme.accentColor)
        UIToolbar.appearance().tintColor = UIColor(Color.theme.accentColor)
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack {
                    HomeView()
                        .navigationBarHidden(true)
                }
                .tint(Color.theme.accentColor)
                .environmentObject(homeVM)
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2)
            }
        }
    }
}
