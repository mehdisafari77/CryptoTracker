//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Mehdi MMS on 14/03/2022.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = []
/*
     =
        [
            StatisticModel(title: "title", value: "value", percentageChange: 1),
            StatisticModel(title: "title", value: "value"),
            StatisticModel(title: "title", value: "value"),
            StatisticModel(title: "title", value: "value", percentageChange: -7)
        ]
*/
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init() {
        
       // DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
       //     self.allCoins.append(DeveloperPreview.instance.coin)
       //     self.portfolioCoins.append(DeveloperPreview.instance.coin)
       // }
        
        addSubscribers()
    }
    
    private func addSubscribers() {
        
        // as below subscriber will work like same way as:
        // to update allcoins array
        // so put comment this code, no need to write twice here
        /*
        coinDataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        */
        
        // updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink(receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            })
            .store(in: &cancellables)
        
        // update portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)

        // updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapMarketGlobalData)
            .sink { [weak self] (returnedStats) in
                guard let self = self else { return }
                self.statistics = returnedStats
                self.isLoading  = false
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        
        // sort - way 1
        //var filteredCoins = filterCoins(text: text, coins: coins)
        // let sortedCoins = sortCoins(sort: sort, coins: filteredCoins)
        
        // sort - way 2 -
        // use same array of coins and just change places insread of create a new array
        // meaning it won't creates a new array like above
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        // make code little cleaner like below:
        /*
        let lowercasedText = text.lowercased()

        let filteredCoins = startingCoins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
                coin.symbol.lowercased().contains(lowercasedText) ||
                coin.id.lowercased().contains(lowercasedText)
        }

        return filteredCoins
         */
        
        let lowercasedText = text.lowercased()

        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
                    coin.symbol.lowercased().contains(lowercasedText) ||
                    coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    // way 1 - sort - which creates new array and then it will returns
    func sortCoins(sort: SortOption, coins: [CoinModel]) -> [CoinModel] {
        
        switch sort {
        case .rank, .holdings:
            return coins.sorted(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            return coins.sorted(by: { $0.rank > $1.rank })
        case .price:
            return coins.sorted(by: { $0.currentPrice < $1.currentPrice })
        case .priceReversed:
            return coins.sorted(by: { $0.currentPrice > $1.currentPrice })
        }
    }
    
    func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        // will only sort by holdings or reversedholdings if needed
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coins
        }
    }
    
    // way 2 - sort - which uses same array and just changes the places of same array
    // ans it won't create new array
    func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        
        switch sort {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice < $1.currentPrice })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        }
    }

    func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    func mapMarketGlobalData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap           = StatisticModel(title: "Market Cap",
                                                 value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume              = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance        = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        
        let portfolioValue      = portfolioCoins
                                    .map({$0.currentHoldingsValue})
                                    .reduce(0, +)
        
        let previousValue       = portfolioCoins
                                    .map { (coin) -> Double in
                                        let currentValue  = coin.currentHoldingsValue
                                        let percentChange = coin.priceChangePercentage24H ?? 0 / 100
                                        let previousValue = currentValue / (1 + percentChange)
                                        return previousValue
                                    }
                                    .reduce(0, +)
        
        let percentageChange    = ((portfolioValue - previousValue) / previousValue)
        
        let portfolio           = StatisticModel(
                                    title: "Portfolio Value",
                                    value: portfolioValue.asCurrencyWith2Decimals(),
                                    percentageChange: percentageChange)
        
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        
        return stats
    }
}
