//
//  PortfolioDataService.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 04/02/25.
//

import CoreData
import UIKit

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "Portfolio"
    
    @Published var savedEntities: [Portfolio] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading container \(error.localizedDescription)")
            }
            self.getPortfolio()
        }
    }
    
    //MARK: PUBLIC METHODS
    
    func updatePortfolio(coin: Coin, amount: Double) {
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                updatePortfolio(coin: coin, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    
    //MARK: PRIVATE METHODS
    
    private func getPortfolio() {
        let request = NSFetchRequest<Portfolio>(entityName: entityName)
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetch Portfolio Entities: \(error.localizedDescription)")
        }
    }
    
    private func add(coin: Coin, amount: Double) {
        let entity = Portfolio(context: container.viewContext)
        entity.coinID = coin.id
        entity.amountHolding = amount
        applyChanges()
    }
    
    private func delete(entity: Portfolio) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func saveData() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data: \(error.localizedDescription)")
        }
    }
    
    private func applyChanges() {
        saveData()
        getPortfolio()
    }
    
}
