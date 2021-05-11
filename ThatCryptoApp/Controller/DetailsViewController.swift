//
//  DetailsViewController.swift
//  ThatCryptoApp
//
//  Created by Jagdeep Singh on 08/05/21.
//

import UIKit
import SwiftChart
class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var chartView: Chart!
    var singleCoinId:String = ""
    var currencyId:String?
    var coin:SingleCoin!
    var currencySymbol:String = "$"
    var coinHistory: [History] = []
    var changeHistory: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CoinAPI.getSingleCoin(currencyUuid: currencyId, uuid: singleCoinId, completion: coinHandler(success:error:))
        CoinAPI.getCoinHistory(timePeriod: nil, currencyUuid: currencyId, uuid: singleCoinId, completion: historyHandler(success:error:))
    }
    func historyHandler(success:Bool,error:Error?) -> Void {
        if success {
            coinHistory = CoinAPI.Const.coinHistory
            changeHistory = CoinAPI.Const.historyChange ?? coin.change ?? "0.00"
            setChangePercentage(changeLabel, percentage: changeHistory)
            setupChartView()
        } else {
            showAlert(message: error?.localizedDescription ?? "Something went wrong", title: "Error")
        }
    }
    
    func coinHandler(success:Bool,error: Error?) -> Void {
        if success {
            coin = CoinAPI.Const.singleCoin
            setupView()
            
        } else {
            showAlert(message: error?.localizedDescription ?? "Something went wrong", title: "Error")
        }
    }
    private func setupChartView() {
        var data:[Double] = []
        
        for i in coinHistory {
            data.append(Double(i.price)!)
        }
        addChartSeries(data)
    }
    private func setupView() {
        navigationController?.navigationBar.topItem?.title = coin.name
        symbolLabel.text = coin.symbol
        setChangePercentage(changeLabel, percentage: coin.change)
        setPrice(priceLabel, price: coin.price, currencySymbol: currencySymbol)
        
    }
    private func addChartSeries(_ data: [Double]) {
        let series = ChartSeries(data)
        series.area = true
        
        if Double(changeHistory)! > 0 {
            series.color = ChartColors.blueColor()
        }
        else {
            series.color = ChartColors.redColor()
        }
        chartView.add(series)
        
        
    }
    
    
}

