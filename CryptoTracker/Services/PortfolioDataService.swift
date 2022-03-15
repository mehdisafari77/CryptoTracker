//
//  PortfolioDataService.swift
//  CryptoTracker
//
//  Created by Mehdi MMS on 14/03/2022.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in // it loads container into this file to further interact
            if let error = error {
                print("Error loading core data container: \(error.localizedDescription)")
            }
            self.getPortfolio()
        }
    }
    
    // MARK: - PUBLIC
    
    // This is the only function we will call
    // from somewhere else in app
    func updatePortfolio(coin: CoinModel, amount: Double) {
        // check if coin is alredy in portfolio
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    
}
