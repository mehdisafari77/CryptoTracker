//
//  MarketDataModel.swift
//  CryptoTracker
//
//  Created by Mehdi MMS on 14/03/2022.
//

import Foundation

// JSON data:
/*
 
 URL:
 https://api.coingecko.com/api/v3/global

 JSON Response:
 {
   "data": {
     "active_cryptocurrencies": 11159,
     "upcoming_icos": 0,
     "ongoing_icos": 50,
     "ended_icos": 3375,
     "markets": 680,
     "total_market_cap": {
       "btc": 47695119.322222106,
       "eth": 634615092.5157933,
       "ltc": 13094145369.419247,
       "bch": 4607051496.84617,
       "bnb": 4382132267.028703,
       "eos": 664309111210.7484,
       "xrp": 2721249534161.1807,
       "xlm": 7858725288376.756,
       "link": 108577330254.62305,
       "dot": 72806134411.74309,
       "yfi": 88780748.0811641,
       "usd": 2593872961231.7563,
       "aed": 9527295386604.252,
       "ars": 261405848061606.12,
       "aud": 3641571970621.762,
       "bdt": 222565889498075.84,
       "bhd": 977892700257.3362,
       "bmd": 2593872961231.7563,
       "brl": 14478316681006.88,
       "cad": 3308523870145.5254,
       "chf": 2396326190377.308,
       "clp": 2162382194130854.5,
       "cny": 16582629841154.646,
       "czk": 58925271447598,
       "dkk": 17073909380011.916,
       "eur": 2296093751409.391,
       "gbp": 1947093332221.5808,
       "hkd": 20232079403959.66,
       "huf": 848702753792214.5,
       "idr": 37407409216755740,
       "ils": 8258178193497.592,
       "inr": 194771383851136.84,
       "jpy": 294246354849169.4,
       "krw": 3101716210220829,
       "kwd": 785811219732.2008,
       "lkr": 525301365425973.1,
       "mmk": 4645357128391656,
       "mxn": 56597244526162.75,
       "myr": 10995427482661.44,
       "ngn": 1063202588079284.6,
       "nok": 23577329921363.273,
       "nzd": 3804228556274.681,
       "php": 131000960034048.88,
       "pkr": 453538687271373.06,
       "pln": 10815962600219.715,
       "rub": 196004972766293.38,
       "sar": 9731114142278.969,
       "sek": 23646378819591.27,
       "sgd": 3555681055256.494,
       "thb": 87491334982347.36,
       "try": 31991013392759.664,
       "twd": 72269194103231.81,
       "uah": 70279439342416.62,
       "vef": 259724499608.13593,
       "vnd": 58854977490348400,
       "zar": 42064837812295.44,
       "xdr": 1853597181333.9827,
       "xag": 112186976916.72426,
       "xau": 1451686941.4829643,
       "bits": 47695119322222.11,
       "sats": 4769511932222211
     },
     "total_volume": {
       "btc": 3682018.075000216,
       "eth": 48991684.56891535,
       "ltc": 1010855630.7651106,
       "bch": 355660015.63478386,
       "bnb": 338296463.9470709,
       "eos": 51284034710.98279,
       "xrp": 210077888759.97238,
       "xlm": 606686155092.2393,
       "link": 8382067142.591729,
       "dot": 5620564675.891952,
       "yfi": 6853789.733461916,
       "usd": 200244537873.7066,
       "aed": 735498187610.1254,
       "ars": 20180284086743.977,
       "aud": 281125909899.88934,
       "bdt": 17181876042159.275,
       "bhd": 75492391022.92548,
       "bmd": 200244537873.7066,
       "brl": 1117712346097.5713,
       "cad": 255414911725.98102,
       "chf": 184994114113.7831,
       "clp": 166933858998415.6,
       "cny": 1280163330626.6086,
       "czk": 4548975191330.786,
       "dkk": 1318089646099.8867,
       "eur": 177256264681.26736,
       "gbp": 150313762599.43588,
       "hkd": 1561897383188.0198,
       "huf": 65519049415805.125,
       "idr": 2887816590718769,
       "ils": 637523541341.968,
       "inr": 15036166509778.617,
       "jpy": 22715540131855.418,
       "krw": 239449556093954.22,
       "kwd": 60663882504.30166,
       "lkr": 40552768287541.71,
       "mmk": 358617174139240.4,
       "mxn": 4369253716143.7446,
       "myr": 848836596046.6442,
       "ngn": 82078233629053.61,
       "nok": 1820147557325.755,
       "nzd": 293682844380.8736,
       "php": 10113150140773.7,
       "pkr": 35012757447217.637,
       "pln": 834982076960.2366,
       "rub": 15131398406611.508,
       "sar": 751232802662.6283,
       "sek": 1825478066923.9536,
       "sgd": 274495212517.27725,
       "thb": 6754248262480.141,
       "try": 2469675958957.789,
       "twd": 5579113392212.836,
       "uah": 5425506207698.973,
       "vef": 20050485577.294254,
       "vnd": 4543548564354391,
       "zar": 3247365670697.9033,
       "xdr": 143095948231.77817,
       "xag": 8660728448.886616,
       "xau": 112068858.0663986,
       "bits": 3682018075000.216,
       "sats": 368201807500021.56
     },
     "market_cap_percentage": {
       "btc": 39.5927953810604,
       "eth": 18.668569793262606,
       "bnb": 3.8357220476721743,
       "usdt": 2.832854773709576,
       "sol": 2.2717439827675356,
       "ada": 1.9338746418072401,
       "xrp": 1.7323456050313226,
       "usdc": 1.4555510378529406,
       "dot": 1.4545979526064272,
       "doge": 1.0487998210911746
     },
     "market_cap_change_percentage_24h_usd": -7.6263174453176745,
     "updated_at": 1637946950
   }
 }
 
 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
//    let activeCryptocurrencies          : Int?
//    let upcomingIcos                    : Int?
//    let ongoingIcos                     : Int?
//    let endedIcos                       : Int?
//    let markets                         : Int?
    let totalMarketCap                  : [String: Double]
    let totalVolume                     : [String: Double]
    let marketCapPercentage             : [String: Double]
    let marketCapChangePercentage24HUsd : Double
//    let updatedAt                       : Int?
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap                     = "total_market_cap"
        case totalVolume                        = "total_volume"
        case marketCapPercentage                = "market_cap_percentage"
        case marketCapChangePercentage24HUsd    = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        
//        if let item = totalMarketCap.first(where: { (key, value) -> Bool in
//            return key == "usd"
//        }) {
//            return "\(item.value)"
//        }
        
        // this is more convient way
        // to write above code as below way
        
        if let item = totalMarketCap.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }

    var btcDominance: String {
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}) {
            return item.value.asPercentString()
        }
        return ""
    }
}
