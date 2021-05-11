//
//  TableViewController.swift
//  ThatCryptoApp
//
//  Created by Jagdeep Singh on 09/05/21.
//

import Foundation
import UIKit
import DropDown

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currencyButton: UIButton!
    var coins:[Coins] = []
    var currencies:[Currency] = []
    var currenciesName:[String] = []
    var selectedCurrencySign: String = "$"
    var singleCoinId:String = ""
    var currencyId:String?
    
    //DropDown Setup
    let menu: DropDown = {
        let menu = DropDown()
        menu.cellNib = UINib(nibName: "DropDownCell", bundle: nil)
        return menu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu.anchorView = currencyButton
        internetChecker { i in
            if i == false {
                self.showAlert(message: "Your Internet Connection is not", title: "Error")
            }
        }
        CoinAPI.getAllCoins(currencyUuid: nil, completion: coinsHandler(success:error:))
        CoinAPI.getAllCurrency(completion: currenciesHandler(success:error:))
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        menu.selectionAction = { index , title in
            self.selectedCurrencySign = self.currencies[index].sign ?? self.currencies[index].symbol
            self.currencyId = self.currencies[index].uuid
            CoinAPI.getAllCoins(currencyUuid: self.currencies[index].uuid, completion: self.coinsHandler(success:error:))
            
        }
    }
    func currenciesHandler(success: Bool,error: Error?) -> Void {
        if success{
            currencies = CoinAPI.Const.allCurrencies
            for c in currencies {
                currenciesName.append(c.name)
            }
            
        }
        else {
           showAlert(message: error?.localizedDescription ?? "Somethting is wrong", title: "Error")
           // print(error)
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
    @IBAction func changeCurrencyAction(_ sender: Any) {
        menu.dataSource = currenciesName
        menu.customCellConfiguration = { index, title, cell in
            guard let cell = cell as? MenuItemCell else {
                return
            }
            cell.symbolAndSignLabel.text = self.currencies[index].sign ?? ""
            cell.optionLabel.text = self.currencies[index].symbol
        }
        menu.show()
        
        
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
        setChangePercentage(cell.changeLabel, percentage: coin.change)
        setPrice(cell.priceLabel,price:coin.price,currencySymbol: selectedCurrencySign)
        CoinAPI.getCoinImage(urlString: coin.iconURL) { image in
            cell.iconView.image = image
    
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        singleCoinId = coins[indexPath.row].uuid
        performSegue(withIdentifier: "DetailsSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailsViewController {
            vc.currencyId = currencyId
            vc.singleCoinId = singleCoinId
            vc.currencySymbol = selectedCurrencySign
        }
    }
    
}
