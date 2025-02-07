//
//  PreviewProvider.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 03/02/25.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    
    static let shared = DeveloperPreview()
    private init() { }
    
    let coin = Coin(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
        currentPrice: 95458,
        marketCap: 1892271381867,
        marketCapRank: 1,
        fullyDilutedValuation: 1892271381867,
        totalVolume: 108203664662,
        high24H: 99395,
        low24H: 92460,
        priceChange24H: -3618.0907189558784,
        priceChangePercentage24H: -3.65183,
        marketCapChange24H: -71229172201.26709,
        marketCapChangePercentage24H: -3.62766,
        circulatingSupply: 19819071.0,
        totalSupply: 19819071.0,
        maxSupply: 21000000.0,
        ath: 108786,
        athChangePercentage: -13.32382,
        athDate: "2025-01-20T09:11:54.494Z",
        atl: 67.81,
        atlChangePercentage: 138954.01976,
        atlDate: "2013-07-06T00:00:00.000Z",
        lastUpdated: "2025-02-03T11:23:02.694Z",
        sparklineIn7D: SparklineIn7D(price: [
            103715.7684209174,
            104106.091328276,
            104062.16245379577,
            104621.97745138497,
            105178.04867984517,
            105402.31611817043,
            105125.3428552742,
            105192.17716115106,
            105162.28920688407,
            105068.55618632458,
            105300.60344458018,
            105314.44377232197,
            105294.1238143463,
            105033.27812610562,
            104869.32058130573,
            105892.90682330292,
            105700.60377366941,
            105684.10403389746,
            105320.05136169468,
            105611.5739729221,
            105790.75505709808,
            105188.81506348633,
            105031.3530846565,
            105121.06862147224,
            104719.69018312056,
            104859.2039947492,
            104736.87599130778,
            104322.18868785404,
            104325.00174294008,
            103991.35346005936,
            104285.77813469055,
            104506.3300564099,
            104217.79035004404,
            104030.89604475061,
            104310.04406200137,
            104274.53389246491,
            104740.66194955219,
            104668.68597425931,
            104614.28446002454,
            104475.41308585052,
            105480.45394517481,
            105071.25945425681,
            104623.76134295262,
            102524.21520732481,
            102310.35586633568,
            101598.16372711949,
            101921.93619140107,
            102231.1283769451,
            97736.3008613856,
            96709.7362968561,
            97377.74729659544,
            97326.90138999239,
            96870.39922901063,
            96439.88149814382
        ]),
        priceChangePercentage24HInCurrency: -3.651831666387792,
        currentHoldings: 1.5
    )
    
    let homeVM = HomeViewModel()
}
