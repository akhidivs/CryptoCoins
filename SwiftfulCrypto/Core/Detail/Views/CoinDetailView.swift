//
//  CoinDetailView.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 05/02/25.
//

import SwiftUI

struct CoinDetailLoadingView: View {
    
    @Binding var coin: Coin?
    
    var body: some View {
        if let coin = coin {
            CoinDetailView(coin: coin)
        }
    }
}

struct CoinDetailView: View {
    
    @State private var showFullDescription: Bool = false
    @StateObject var vm: CoinDetailViewModel
    let coin: Coin
    
    private let gridColumns: [GridItem] = [
        GridItem(.flexible(minimum: 0, maximum: .infinity)),
        GridItem(.flexible(minimum: 0, maximum: .infinity))
    ]
    
    private let spacing: CGFloat = 30
    
    init(coin: Coin) {
        self.coin = coin
        _vm = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ChartView(coin: coin)
                    .padding(.vertical)
                overviewGrid
                additionalDetailsGrid
                websiteSection
            }
            .padding()
        }
        .background(
            Color.theme.backgroundColor
        )
        .navigationTitle(coin.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                navigationBarTrailingItems
            }
        }
    }
}

#Preview {
    NavigationStack {
        CoinDetailView(coin: DeveloperPreview.shared.coin)
    }
}

extension CoinDetailView {
    
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryTextColor)
            CoinImageView(coin: coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overviewGrid: some View {
        
        VStack {
            Text("Overview")
                .bold()
                .foregroundStyle(Color.theme.accentColor)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            ZStack{
                if let description = vm.description, !description.isEmpty {
                    VStack(alignment: .leading) {
                        Text(description)
                            .font(.callout)
                            .foregroundStyle(Color.theme.secondaryTextColor)
                            .lineLimit(showFullDescription ? nil : 3)
                        
                        Button {
                            withAnimation(.default) {
                                showFullDescription.toggle()
                            }
                        } label: {
                            Text(showFullDescription ? "Less" : "Read more..")
                                .bold()
                                .font(.caption)
                                .foregroundStyle(Color.blue)
                        }
                        .padding(.top, 2)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 8)
                }
            }
            
            LazyVGrid(columns: gridColumns,
                      alignment: .leading,
                      spacing: spacing) {
                ForEach(vm.overviewStat) { stat in
                    StatisticsView(stat: stat)
                }
            }
        }
    }
    
    private var additionalDetailsGrid: some View {
        
        VStack {
            Text("Additional Details")
                .bold()
                .foregroundStyle(Color.theme.accentColor)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVGrid(columns: gridColumns,
                      alignment: .leading,
                      spacing: spacing) {
                ForEach(vm.additionalStat) { stat in
                    StatisticsView(stat: stat)
                }
            }
        }
    }
    
    private var websiteSection: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            if let websiteString = vm.websiteURL,
               let homeWebsite = URL(string: websiteString) {
                Link("Website", destination: homeWebsite)
            }
            
            if let redditUrlString = vm.redditURL,
               let redditWebsite = URL(string: redditUrlString) {
                Link("Reddit", destination: redditWebsite)
            }
        }
        .tint(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
}
