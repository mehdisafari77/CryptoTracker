//
//  CoinModel.swift
//  CryptoTracker
//
//  Created by Mehdi MMS on 14/03/2022.
//

import Foundation

// Coingecko API info:
/*
URL:
    https://api.coingecko.com/api/v3/coins/markets?
    vs_currency=usd&
    order=market_cap_desc&
    per_page=1&
    page=1&
    sparkline=true&
    price_change_percentage=24h
 
JSON Respone:
 {
    "id": "bitcoin",
    "symbol": "btc",
    "name": "Bitcoin",
    "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
    "current_price": 57187,
    "market_cap": 1080276059199,
    "market_cap_rank": 1,
    "fully_diluted_valuation": 1201496722769,
    "total_volume": 37413142234,
    "high_24h": 57955,
    "low_24h": 55866,
    "price_change_24h": 37.63,
    "price_change_percentage_24h": 0.06584,
    "market_cap_change_24h": -694768832.6202393,
    "market_cap_change_percentage_24h": -0.06427,
    "circulating_supply": 18881281,
    "total_supply": 21000000,
    "max_supply": 21000000,
    "ath": 69045,
    "ath_change_percentage": -17.1327,
    "ath_date": "2021-11-10T14:24:11.849Z",
    "atl": 67.81,
    "atl_change_percentage": 84277.49417,
    "atl_date": "2013-07-06T00:00:00.000Z",
    "roi": null,
    "last_updated": "2021-11-23T18:35:23.163Z",
    "sparkline_in_7d": {
      "price": [
        60771.018595568996,
        56174.20757045411,
        57588.3374152355
      ]
    },
    "price_change_percentage_24h_in_currency": 0.06583802189757061
  }
 */

struct CoinModel: Identifiable, Codable {

    let id                                  : String
    let symbol                              : String
    let name                                : String
    let image                               : String
    let currentPrice                        : Double
    let marketCap                           : Double?
    let marketCapRank                       : Double?
    let fullyDilutedValuation               : Double?
    let totalVolume                         : Double?
    let high24H                             : Double?
    let low24H                              : Double?
    let priceChange24H                      : Double?
    let priceChangePercentage24H            : Double?
    let marketCapChange24H                  : Double?
    let marketCapChangePercentage24H        : Double?
    let circulatingSupply                   : Double?
    let totalSupply                         : Double?
    let maxSupply                           : Double?
    let ath                                 : Double?
    let athChangePercentage                 : Double?
    let athDate                             : String?
    let atl                                 : Double?
    let atlChangePercentage                 : Double?
    let atlDate                             : String?
    let lastUpdated                         : String?
    let sparklineIn7D                       : SparklineIn7D?
    let priceChangePercentage24HInCurrency  : Double?
    let currentHoldings                     : Double?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice                        = "current_price"
        case marketCap                           = "market_cap"
        case marketCapRank                       = "market_cap_rank"
        case fullyDilutedValuation               = "fully_diluted_valuation"
        case totalVolume                         = "total_volume"
        case high24H                             = "high_24h"
        case low24H                              = "low_24h"
        case priceChange24H                      = "price_change_24h"
        case priceChangePercentage24H            = "price_change_percentage_24h"
        case marketCapChange24H                  = "market_cap_change_24h"
        case marketCapChangePercentage24H        = "market_cap_change_percentage_24h"
        case circulatingSupply                   = "circulating_supply"
        case totalSupply                         = "total_supply"
        case maxSupply                           = "max_supply"
        case ath
        case athChangePercentage                 = "ath_change_percentage"
        case athDate                             = "ath_date"
        case atl
        case atlChangePercentage                 = "atl_change_percentage"
        case atlDate                             = "atl_date"
        case lastUpdated                         = "last_updated"
        case sparklineIn7D                       = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency  = "price_change_percentage_24h_in_currency"
        case currentHoldings

    }
    
    func updateHoldings(amount: Double) -> CoinModel {
        
        return CoinModel(
            id                                  : id                                  ,
            symbol                              : symbol                              ,
            name                                : name                                ,
            image                               : image                               ,
            currentPrice                        : currentPrice                        ,
            marketCap                           : marketCap                           ,
            marketCapRank                       : marketCapRank                       ,
            fullyDilutedValuation               : fullyDilutedValuation               ,
            totalVolume                         : totalVolume                         ,
            high24H                             : high24H                             ,
            low24H                              : low24H                              ,
            priceChange24H                      : priceChange24H                      ,
            priceChangePercentage24H            : priceChangePercentage24H            ,
            marketCapChange24H                  : marketCapChange24H                  ,
            marketCapChangePercentage24H        : marketCapChangePercentage24H        ,
            circulatingSupply                   : circulatingSupply                   ,
            totalSupply                         : totalSupply                         ,
            maxSupply                           : maxSupply                           ,
            ath                                 : ath                                 ,
            athChangePercentage                 : athChangePercentage                 ,
            athDate                             : athDate                             ,
            atl                                 : atl                                 ,
            atlChangePercentage                 : atlChangePercentage                 ,
            atlDate                             : atlDate                             ,
            lastUpdated                         : lastUpdated                         ,
            sparklineIn7D                       : sparklineIn7D                       ,
            priceChangePercentage24HInCurrency  : priceChangePercentage24HInCurrency  ,
            currentHoldings                     : amount
        )
    }
    
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
