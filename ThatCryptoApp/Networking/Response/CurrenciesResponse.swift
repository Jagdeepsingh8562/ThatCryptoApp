//
//  CurrenciesResponse.swift
//  ThatCryptoApp
//
//  Created by Jagdeep Singh on 09/05/21.
//

import Foundation
// MARK: - CurrencyResponse
struct CurrencyResponse: Codable {
    let status: String
    let data: DataClass
}


// MARK: - Currency
struct Currency: Codable {
    let uuid: String
    let type: TypeEnum
    let iconURL: String?
    let name, symbol: String
    let sign: String?

    enum CodingKeys: String, CodingKey {
        case uuid, type
        case iconURL = "iconUrl"
        case name, symbol, sign
    }
}

enum TypeEnum: String, Codable {
    case coin = "coin"
    case denominator = "denominator"
    case fiat = "fiat"
}

//// MARK: - Stats
//struct Stats: Codable {
//    let total: Int
//}
