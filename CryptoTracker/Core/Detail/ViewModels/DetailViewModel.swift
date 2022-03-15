//
//  DetailViewModel.swift
//  CryptoTracker
//
//  Created by Mehdi MMS on 14/03/2022.
//

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics   : [StatisticModel]   = []
    @Published var additionalStatistics : [StatisticModel]   = []
    @Published var coin: CoinModel
    @Published var coinDescription: String?
    @Published var websiteURL: String?
    @Published var redditURL: String?
    
    
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    
    
    
}
