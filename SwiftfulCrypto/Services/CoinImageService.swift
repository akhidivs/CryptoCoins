//
//  CoinImageService.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 04/02/25.
//

import Combine
import Foundation
import SwiftUI

class CoinImageService {
    
    @Published var coinImage: UIImage? = nil
    
    private let coin: Coin
    private var coinImageSubscription: AnyCancellable?
    private let fileManager = LocalFileManager.shared
    private let imageName: String
    private let folderName = "coin_images"
    
    init(coin: Coin) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let image = fileManager.getImage(imageName: imageName, folderName: folderName) {
            self.coinImage = image
        } else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else {
            return
        }
        
        coinImageSubscription = NetworkingManager.downloadData(url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnImage in
                guard let self = self,
                      let downloadedImage = returnImage else { return }
                self.coinImage = downloadedImage
                self.coinImageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, with: imageName, and: folderName)
            })
    }
}
