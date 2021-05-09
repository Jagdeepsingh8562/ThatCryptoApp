//
//  CommonSturct.swift
//  ThatCryptoApp
//
//  Created by Jagdeep Singh on 09/05/21.
//

import Foundation
// MARK: - DataClass
struct DataClass: Codable {
    let stats: Stats
    let coins: [Coin]
    let currencies: [Currency]
}
// MARK: - Stats
struct Stats: Codable {
    let total, totalMarkets, totalExchanges: Int
    let totalMarketCap, total24HVolume: String

    enum CodingKeys: String, CodingKey {
        case total, totalMarkets, totalExchanges, totalMarketCap
        case total24HVolume = "total24hVolume"
    }
}
