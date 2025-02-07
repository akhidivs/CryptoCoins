//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 03/02/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var stats: [Statistic] = []
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var sortOption: SortOptions = .rank
    
    @Published var selectedCoin: Coin? = nil
    @Published var showCoinDetailView: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    enum SortOptions {
        case rank, rankReversed, holding, holdingReversed, price, priceReversed
    }
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        
        // updates all coins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] filteredCoins in
                self?.allCoins = filteredCoins
            }
            .store(in: &cancellables)
        
        // updates portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] portfolioCoins in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: portfolioCoins)
            }
            .store(in: &cancellables)
        
        // updates market data
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(handleMarketData)
            .sink { [weak self] stats in
                self?.stats = stats
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
        
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HepticManager.notification(type: .success)
    }
    
    func segue(coin: Coin) {
        selectedCoin = coin
        showCoinDetailView.toggle()
    }
    
    private func filterAndSortCoins(text: String, allCoins: [Coin], sortOption: SortOptions) -> [Coin] {
        var updatedCoins = filterCoins(text: text, allCoins: allCoins)
        sortCoins(coins: &updatedCoins, sortOption: sortOption)
        return updatedCoins
    }
    
    private func filterCoins(text: String, allCoins: [Coin]) -> [Coin] {
        guard !text.isEmpty else {
            return allCoins
        }
        
        let lowercasedText = text.lowercased()
        return allCoins.filter { coin in
                coin.name.lowercased().contains(lowercasedText) ||
                coin.symbol.lowercased().contains(lowercasedText) ||
                coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private func sortCoins(coins: inout [Coin], sortOption: SortOptions) {
        switch sortOption {
        case .rank, .holding:
            coins.sort{ $0.rank < $1.rank }
        case .rankReversed, .holdingReversed:
            coins.sort { $0.rank > $1.rank }
        case .price:
            coins.sort { $0.currentPrice < $1.currentPrice }
        case .priceReversed:
            coins.sort { $0.currentPrice > $1.currentPrice }
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [Coin]) -> [Coin] {
        // filter only for holding and holding reversed option
        switch sortOption {
        case .holding:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coins
        }
    }
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [Coin], portfolioEntities: [Portfolio]) -> [Coin] {
        allCoins.compactMap { coin in
            guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                return nil
            }
            return coin.updateHoldings(amount: entity.amountHolding)
        }
    }
    
    private func handleMarketData(marketData: MarketData?, portfolioCoins: [Coin]) -> [Statistic] {
        var stats: [Statistic] = []
        guard let data = marketData else {
            return stats
        }
        
        let marketStat = Statistic(name: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volumeStat = Statistic(name: "24h Volume", value: data.volume)
        let btcDominanceStat = Statistic(name: "BTC Dominance", value: data.bitCoinDominance)
        
        let portfolioValue = portfolioCoins
            .map({ return $0.currentHoldingsValue })
            .reduce(0, +)
        
        let previousValue = portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                return currentValue / (1 + percentChange)
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue)/previousValue) * 100
        
        let portfolioStat = Statistic(name: "Portfolio Value",
                                      value: portfolioValue.asCurrencyWith2Decimal(),
                                      percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketStat,
            volumeStat,
            btcDominanceStat,
            portfolioStat
        ])
        return stats
    }
}
