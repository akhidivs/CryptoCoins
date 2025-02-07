//
//  CoinImageView.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 04/02/25.
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject var vm: CoinImageViewModel
    let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.coinImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondaryTextColor)
            }
        }
    }
}

#Preview {
    CoinImageView(coin: DeveloperPreview.shared.coin)
}
