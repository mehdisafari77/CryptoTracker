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
    
    
}
