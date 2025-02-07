//
//  Coin.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 03/02/25.
//

import Foundation

// CoinGecko API info...
/*
 
 URL: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 
 {
     "id":"bitcoin",
     "symbol":"btc",
     "name":"Bitcoin",
     "image":"https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
     "current_price":95458,
     "market_cap":1892271381867,
     "market_cap_rank":1,
     "fully_diluted_valuation":1892271381867,
     "total_volume":108203664662,
     "high_24h":99395,
     "low_24h":92460,
     "price_change_24h":-3618.0907189558784,
     "price_change_percentage_24h":-3.65183,
     "market_cap_change_24h":-71229172201.26709,
     "market_cap_change_percentage_24h":-3.62766,
     "circulating_supply":19819071.0,
     "total_supply":19819071.0,
     "max_supply":21000000.0,
     "ath":108786,
     "ath_change_percentage":-13.32382,
     "ath_date":"2025-01-20T09:11:54.494Z",
     "atl":67.81,
     "atl_change_percentage":138954.01976,
     "atl_date":"2013-07-06T00:00:00.000Z",
     "roi":null,
     "last_updated":"2025-02-03T11:23:02.694Z",
     "sparkline_in_7d": {
         "price":[
             100385.40284056596,
             98910.61330253117,
             99264.17133349284
         ]
     },
     "price_change_percentage_24h_in_currency":-3.651831666387792
 }
 
 */

struct Coin: Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings = "current_holdings"
    }
    
    func updateHoldings(amount: Double) -> Coin {
        return Coin(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingsValue: Double {
        return currentPrice * (currentHoldings ?? 0)
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
    
    var marketCapAbbr: String {
        return "$" + (marketCap?.formattedWithAbbreviations() ?? "0.00")
    }
    
    var totalVolumeAbbr: String {
        return "$" + (totalVolume?.formattedWithAbbreviations() ?? "0.00")
    }
    
    var marketCapChangeAbbr: String {
        return "$" + (marketCapChange24H?.formattedWithAbbreviations() ?? "0.00")
    }
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
