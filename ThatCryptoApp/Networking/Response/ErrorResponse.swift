//
//  ErrorResponse.swift
//  ThatCryptoApp
//
//  Created by Jagdeep Singh on 09/05/21.
//

import Foundation

// MARK: - ErrorResponse
struct ErrorResponse: Codable {
    let status, type, message: String
}
