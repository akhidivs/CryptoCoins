//
//  CoinImageViewModel.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 04/02/25.
//

import Combine
import Foundation
import SwiftUI

class CoinImageViewModel: ObservableObject {
    
    @Published var coinImage: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: Coin
    private var cancellables = Set<AnyCancellable>()
    private let coinImageService: CoinImageService
    
    init(coin: Coin) {
        self.isLoading = true
        self.coin = coin
        self.coinImageService = CoinImageService(coin: coin)
        getCoinImage()
    }
    
    private func getCoinImage() {
        coinImageService.$coinImage
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { coinImage in
                self.coinImage = coinImage
            }
            .store(in: &cancellables)

    }
}

