//
//  CoinDetailDataService.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 05/02/25.
//

import Combine
import Foundation

class CoinDetailDataService {
    
    @Published var coinDetails: CoinDetail? = nil
    
    var coinDetailSubscription: AnyCancellable?
    let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        getCoinDetails()
    }
    
    private func getCoinDetails() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else {
            return
        }
        
        coinDetailSubscription = NetworkingManager.downloadData(url)
            .decode(type: CoinDetail.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] coinDetail in
                self?.coinDetails = coinDetail
                self?.coinDetailSubscription?.cancel()
            }

    }
}
