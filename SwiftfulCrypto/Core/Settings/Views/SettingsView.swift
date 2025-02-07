//
//  SettingsView.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 06/02/25.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let linkedInURL = URL(string: "https://www.linkedin.com/in/akhilesh-mishra-9510b073")!
    let githubLinkDev = URL(string: "https://github.com/akhidivs")!
    let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
    let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
    let coinGeckoURL = URL(string: "https://www.coingecko.com")!
    
    var body: some View {
        NavigationStack {
            ZStack {
                //background layer
                Color.theme.backgroundColor
                    .ignoresSafeArea()
                
                //content layer
                List {
                    developerSection
                        .listRowBackground(Color.white.opacity(0.3))
                    appSection
                        .listRowBackground(Color.white.opacity(0.3))
                    apiSection
                        .listRowBackground(Color.white.opacity(0.3))
                }
                .tint(.blue)
                .listStyle(.grouped)
            }
            .scrollContentBackground(.hidden)
            .font(.headline)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CloseButtonView().onTapGesture {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {
    
    private var developerSection: some View {
        
        Section {
            VStack(alignment: .leading) {
                Image("developer")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(12)
                Text("My name is Akhilesh Mishra and I've around 10 years of experience developing iOS native apps.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accentColor)
            }
            .padding(.vertical)
            Link("View my LinkedIn 🥳", destination: linkedInURL)
            Link("View my Github 🥳", destination: githubLinkDev)
        } header: {
            Text("DEVELOPER INFO")
        }
    }
    
    private var appSection: some View {
        
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(12)
                Text("This app was made by following a @SwiftfulThinking course on YouTube. It uses SwiftUI, CoreData, Combine and MVVM architecture.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accentColor)
            }
            .padding(.vertical)
            Link("Subscribe on YouTube 🥳", destination: youtubeURL)
            Link("Buy Nick a Coffee 🥳", destination: coffeeURL)
        } header: {
            Text("APP INFO")
        }
    }
    
    private var apiSection: some View {
        
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .cornerRadius(12)
                Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed and hitting the API is limited.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accentColor)
            }
            .padding(.vertical)
            Link("Visit CoinGecko 🥳", destination: coinGeckoURL)
        } header: {
            Text("API INFO")
        }
    }
}
