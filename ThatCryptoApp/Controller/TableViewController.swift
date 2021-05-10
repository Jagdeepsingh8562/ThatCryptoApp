//
//  TableViewController.swift
//  ThatCryptoApp
//
//  Created by Jagdeep Singh on 09/05/21.
//

import Foundation
import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var coins:[Coins] = []
    var currencies:[Currency] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        internetChecker { i in
            if i == false {
                self.showAlert(message: "Your Internet Connection is not", title: "Error")
            }
        }
        CoinAPI.getAllCoins(currencyUuid: nil, completion: coinsHandler(success:error:))
        CoinAPI.getAllCurrency(completion: currenciesHandler(success:error:))
    }
    func currenciesHandler(success: Bool,error: Error?) -> Void {
        if success{
            currencies = CoinAPI.Const.allCurrencies
        }
        else {
           showAlert(message: error?.localizedDescription ?? "Somethting is wrong", title: "Error")
        }
    }
    func coinsHandler(success: Bool,error: Error?) -> Void {
        if success {
            coins = CoinAPI.Const.allCoins
            tableView.reloadData()
        }
        else {
            showAlert(message: error?.localizedDescription ?? "Somethting is wrong", title: "Error")
        }
    }
}
let imageCache = NSCache<AnyObject, AnyObject>()

extension TableViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! TableCell
        let coin = coins[indexPath.row]
        
        cell.titleLabel.text = coin.name
        cell.symbolLabel.text = coin.symbol
        cell.setChange(coin.change)
        cell.setPrice(coin.price, currencySymbol: "$")
        CoinAPI.getCoinImage(urlString: coin.iconURL) { image in
            cell.iconView.image = image
    
        }
        return cell
    }
    
    
}
