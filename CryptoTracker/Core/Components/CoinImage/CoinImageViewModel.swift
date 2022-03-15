//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by Mehdi MMS on 14/03/2022.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    
    private let coin: CoinModel
    private let dataService: CoinImageService
    private var cancelllables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        
        self.coin           = coin
        self.dataService    = CoinImageService(coin: coin)
        self.isLoading      = true
        
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink { (_) in
                self.isLoading = false
            } receiveValue: { (image) in
                self.image = image
            }
            .store(in: &cancelllables)
    }
    
}
