//
//  CoinDetailViewModel.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 05/02/25.
//

import Combine
import Foundation

class CoinDetailViewModel: ObservableObject {
    
    @Published var overviewStat: [Statistic] = []
    @Published var additionalStat: [Statistic] = []
    @Published var description: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil
    @Published var coin: Coin
    
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coin = coin
        coinDetailDataService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        
        coinDetailDataService.$coinDetails
            .combineLatest($coin)
            .map(mapCoinDetailToStat)
            .sink(receiveValue: { [weak self] overview, additionalDetail in
                self?.overviewStat = overview
                self?.additionalStat = additionalDetail
            })
            .store(in: &cancellables)
        
        coinDetailDataService.$coinDetails
            .sink { [weak self] coinDetail in
                self?.description = coinDetail?.readableDescription
                self?.websiteURL = coinDetail?.links?.homepage?.first
                self?.redditURL = coinDetail?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    
    private func mapCoinDetailToStat(coinDetail: CoinDetail?,
                                     coin: Coin) -> (overview: [Statistic], additionalDetail: [Statistic]) {
        let overviewArray = self.createOverviewArray(coin: coin)
        let additionalDetailsArray = self.createAdditionalDetailsArray(coin: coin, detail: coinDetail)
        
        return (overviewArray, additionalDetailsArray)
    }
    
    private func createOverviewArray(coin: Coin) -> [Statistic] {
        
        let currentPrice = coin.currentPrice.asCurrencyWith2Decimal()
        let percentageChange = coin.priceChangePercentage24H
        let priceStat = Statistic(name: "Current Price", value: currentPrice, percentageChange: percentageChange)
        
        let marketCap = coin.marketCapAbbr
        let marketChange = coin.marketCapChangePercentage24H
        let marketStat = Statistic(name: "Market Capitalization", value: marketCap, percentageChange: marketChange)
        
        let rankStat = Statistic(name: "Rank", value: "\(coin.rank)")
        
        let volumeStat = Statistic(name: "Volume", value: coin.totalVolumeAbbr)
        
        return [
            priceStat,
            marketStat,
            rankStat,
            volumeStat
        ]
    }
    
    private func createAdditionalDetailsArray(coin: Coin, detail: CoinDetail?) -> [Statistic] {
        
        let high24H = coin.high24H?.asCurrencyWith2Decimal() ?? "N/A"
        let high24HStat = Statistic(name: "24h High", value: high24H)
        
        let low24H = coin.low24H?.asCurrencyWith2Decimal() ?? "N/A"
        let low24HStat = Statistic(name: "24h Low", value: low24H)
        
        let priceChange24H = coin.priceChange24H?.asCurrencyWith6Decimal() ?? "N/A"
        let priceChange24HPercent = coin.priceChangePercentage24H
        let priceChangeStat = Statistic(name: "24h Price Change", value: priceChange24H, percentageChange: priceChange24HPercent)
        
        let marketCapChange24H = coin.marketCapChangeAbbr
        let marketCapChange24HPercent = coin.marketCapChangePercentage24H
        let marketCapChangeStat = Statistic(name: "24h Market Cap Change", value: marketCapChange24H, percentageChange: marketCapChange24HPercent)
        
        let blockTimeStat = Statistic(name: "Block Time", value: detail?.blockTime ?? "N/A")
        
        let hashAlgoStat = Statistic(name: "Hashing Algorithm", value: detail?.hashAlgo ?? "N/A")
        
        return [high24HStat, low24HStat, priceChangeStat, marketCapChangeStat, blockTimeStat, hashAlgoStat]
    }
}
