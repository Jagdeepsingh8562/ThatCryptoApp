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
        static var allCoins: [Coin] = []
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
    class func getAllCoins(completion: @escaping(Bool,Error?)->Void) {
        let _ = taskForGETRequest(url: Endpoints.getcoins.url, responseType: CoinsResponse.self) { response, error in
            guard let response = response else {
                completion(false,error)
                return
            }
            Const.allCoins = response.data.coins
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
