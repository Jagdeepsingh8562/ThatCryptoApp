//
//  CoinAPI.swift
//  ThatCryptoApp
//
//  Created by Jagdeep Singh on 09/05/21.
//

import Foundation
import UIKit

class CoinAPI {
    struct Const {
        static var ApiKey: String = "coinranking25346f10c91eccd30a3bbef86583dcd8b37cb76c4b2b240b"//as header
        static let baseurl: String = "https://api.coinranking.com/v2"
        static var allCoins: [Coins] = []
        static var allCurrencies: [Currency] = []
        static var singleCoin: SingleCoin!
    }
    enum Endpoints {
        case getcoins
        case getcoin(String)
        case getcurrencies
        
        var stringValue: String {
            switch self {
            case .getcoins: return Const.baseurl + "/coins"
            case .getcoin(let uuid): return Const.baseurl + "/coin/\(uuid)"
            case .getcurrencies: return Const.baseurl + "reference-currencies"
            
            }
        }
        var url: URL {
            return URL(string: stringValue)! }
    }
    class func getAllCoins(currencyUuid: String?, completion: @escaping(Bool,Error?)->Void) {
        var urlComps = URLComponents(string: Endpoints.getcoins.stringValue)!
        if let uuid = currencyUuid {
            let queryItems = [URLQueryItem(name: "referenceCurrencyUuid", value: uuid)]
            urlComps.queryItems = queryItems
        }
        let _ = taskForGETRequest(url: urlComps.url!, responseType: CoinsResponse.self) { response, error in
            guard let response = response else {
                completion(false,error)
                return
            }
            Const.allCoins = response.data.coins
            completion(true,nil)
        }
    }
    class func getAllCurrency(completion: @escaping(Bool,Error?)->Void) {
        let _ = taskForGETRequest(url: Endpoints.getcurrencies.url, responseType: CurrencyResponse.self) { response, error in
            guard let response = response else {
                completion(false,error)
                return
            }
            Const.allCurrencies = response.data.currencies
            completion(true,nil)
        }
    }
    class func getSingleCoin(uuid: String,completion: @escaping(Bool,Error?)->Void) {
        let _ = taskForGETRequest(url: Endpoints.getcoin(uuid).url, responseType: SingleCoinResponse.self) { response, error in
            guard let response = response else {
                completion(false,error)
                return
            }
            Const.singleCoin = response.data.coin
            completion(true,nil)
        }
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            do {
                let responseObject = try JSONDecoder().decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data) as! Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
               // completion(nil,error)
            }
        }
        task.resume()
        
        return task
    }
}
