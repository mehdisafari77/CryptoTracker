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
    
    private func addSubscribers() {
        coinDetailDataService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStats)
            .sink { [weak self] (returnedArrays) in
                guard let self = self else { return }
                self.overviewStatistics    = returnedArrays.overview
                self.additionalStatistics  = returnedArrays.additional
            }
            .store(in: &cancellables)
        
        coinDetailDataService.$coinDetails
            .sink { [weak self] (returnedCoinDetails) in
                guard let self       = self else { return }
                self.coinDescription = returnedCoinDetails?.readableDescription
                self.websiteURL      = returnedCoinDetails?.links?.homepage?.first
                self.redditURL       = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStats(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
        
        let overviewArray   = createOverviewArray(coinModel: coinModel)
        let additionalArray = createAdditionalArray(coinDetailModel: coinDetailModel, coinModel: coinModel)
        
        return (overviewArray, additionalArray)
    }
    
    private func createOverviewArray(coinModel: CoinModel) -> [StatisticModel] {
        
        let price                   = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePercentChange      = coinModel.priceChangePercentage24H
        let priceStat               = StatisticModel(title: "Price Change", value: price, percentageChange: pricePercentChange)
                
        let marketCap               =  "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange  = coinModel.marketCapChangePercentage24H
        let marketStat              = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)

        let rank                    = "\(coinModel.rank)"
        let rankStat                = StatisticModel(title: "Rank", value: rank)
                
        let volume                  = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat              = StatisticModel(title: "Volume", value: volume)
            
        let overviewArray: [StatisticModel] = [
            priceStat, marketStat, rankStat, volumeStat
        ]
        
        return overviewArray
    }
    
    
}
