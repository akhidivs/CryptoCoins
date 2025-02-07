//
//  MarketData.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 04/02/25.
//

import Foundation

// Coin Gecko API info
/*
 
 URL: https://api.coingecko.com/api/v3/global
 
 {
   "data": {
     "active_cryptocurrencies": 17046,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 1227,
     "total_market_cap": {
        "btc": 34034923.46303509,
        "usd": 3371340006783.6304,
        "aed": 12382796991316.0,
        "ars": 3.551320311239715e+15,
        "aud": 5431606341009.188,
        "inr": 293642207601871.1,
        "jpy": 523621358823602.75,
     },
     "total_volume": {
       "btc": 2772336.130389155,
       "usd": 274614623969.5171,
       "aed": 1008648529255.0774,
       "ars": 289275033044447.56,
       "aud": 442434916052.7767,
       "inr": 23918810995008.023,
       "jpy": 42651907629137.516
     },
     "market_cap_percentage": {
       "btc": 58.232371292168594,
       "eth": 9.879613614043382,
       "xrp": 4.442870134431372,
       "usdt": 4.16349866667401,
       "sol": 3.0062759011059708,
       "bnb": 2.525271781122216,
       "usdc": 1.6185124368357642,
       "doge": 1.1793405590212571,
       "ada": 0.7985689338376518,
       "steth": 0.7743195604321171
     },
     "market_cap_change_percentage_24h_usd": 2.3029784673095555,
     "updated_at": 1738670476
   }
 }
 
 */

struct GlobalData: Codable {
    let data: MarketData?
}

// MARK: - DataClass
struct MarketData: Codable {
    
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]?
    let marketCapChangePercentage24HUsd: Double?

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let marketCap = totalMarketCap?.first(where: { $0.key == "usd" }) {
            return "$" + marketCap.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let volume = totalVolume?.first(where: { $0.key == "usd" }) {
            return "$" + volume.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var bitCoinDominance: String {
        if let btc = marketCapPercentage?.first(where: { $0.key == "btc" }) {
            return btc.value.formattedWithAbbreviations() + "%"
        }
        return ""
    }
}
