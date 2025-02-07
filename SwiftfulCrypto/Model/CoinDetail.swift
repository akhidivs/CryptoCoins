//
//  CoinDetail.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 05/02/25.
//

import Foundation

// Coin Gecko API Info
/*
 
 URL: https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false
 
 {
   "id": "bitcoin",
   "symbol": "btc",
   "name": "Bitcoin",
   "block_time_in_minutes": 10,
   "hashing_algorithm": "SHA-256",
   "description": {
     "en": "description"
   },
   "links": {
     "homepage": [
       "http://www.bitcoin.org"
     ],
     "subreddit_url": "https://www.reddit.com/r/Bitcoin/",
   },
   "last_updated": "2025-02-05T13:31:47.080Z"
 }
 
 */

struct CoinDetail: Codable {
    let id, symbol, name, webSlug: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let description: Description?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case webSlug = "web_slug"
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        case description, links
    }
    
    var blockTime: String {
        if let duration = blockTimeInMinutes {
            return "\(duration) min"
        }
        return "N/A"
    }
    
    var hashAlgo: String {
        return hashingAlgorithm ?? "N/A"
    }
    
    var readableDescription: String {
        return description?.en?.removingHTMLOccurences ?? ""
    }
}

struct Description: Codable {
    let en: String?
}

// MARK: - Links
struct Links: Codable {
    let homepage: [String]?
    let subredditURL: String?

    enum CodingKeys: String, CodingKey {
        case homepage
        case subredditURL = "subreddit_url"
    }
}
