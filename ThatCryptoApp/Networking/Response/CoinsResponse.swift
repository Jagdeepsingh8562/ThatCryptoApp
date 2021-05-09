//
//  CoinsResponse.swift
//  ThatCryptoApp
//
//  Created by Jagdeep Singh on 09/05/21.
//

import Foundation

// MARK: - CoinsResponse
struct CoinsResponse: Codable {
    let status: String
    let data: DataClass
}



// MARK: - Coin
struct Coin: Codable {
    let uuid, symbol, name: String
    let color: String?
    let iconURL: String
    let marketCap, price: String
    let listedAt, tier: Int
    let change: String
    let rank: Int
    let sparkline: [String]
    let lowVolume: Bool
    let coinrankingURL: String
    let the24HVolume, btcPrice: String

    enum CodingKeys: String, CodingKey {
        case uuid, symbol, name, color
        case iconURL = "iconUrl"
        case marketCap, price, listedAt, tier, change, rank, sparkline, lowVolume
        case coinrankingURL = "coinrankingUrl"
        case the24HVolume = "24hVolume"
        case btcPrice
    }
}


