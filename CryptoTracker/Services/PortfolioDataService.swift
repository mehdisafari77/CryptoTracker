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
    
    
    
}
