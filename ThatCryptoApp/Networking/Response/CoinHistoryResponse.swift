//
//  CoinHistoryResponse.swift
//  ThatCryptoApp
//
//  Created by Jagdeep Singh on 11/05/21.
//
import Foundation

// MARK: - HistoryResponse
struct HistoryResponse: Codable {
    let status: String
    let data: HistoryDataClass
}

// MARK: - DataClass
struct HistoryDataClass: Codable {
    let change: String?
    let history: [History]
}

// MARK: - History
struct History: Codable {
    let price: String
    let timestamp: Int
}
