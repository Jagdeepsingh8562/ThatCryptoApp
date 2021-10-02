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
    
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var allTimeHighLabel: UILabel!
    @IBOutlet weak var noOfMarketsLabel: UILabel!
    
    @IBOutlet weak var threeHourButton: UIButton!
    @IBOutlet weak var twetyHourButton: UIButton!
    @IBOutlet weak var sevenDayButton: UIButton!
    @IBOutlet weak var thirtyDayButton: UIButton!
    @IBOutlet weak var oneYearButton: UIButton!
    @IBOutlet weak var threeMonthButton: UIButton!

    
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
        roundButtons()
    }
    func roundButtons() {
        threeHourButton.layer.cornerRadius = 10
        twetyHourButton.layer.cornerRadius = 10
        sevenDayButton.layer.cornerRadius = 10
        thirtyDayButton.layer.cornerRadius = 10
        threeMonthButton.layer.cornerRadius = 10
        oneYearButton.layer.cornerRadius = 10
    }
    func historyHandler(success:Bool,error:Error?) -> Void {
        if success {
            chartView.removeAllSeries()
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
            showAlert(message: "\(String(describing: error))" , title: "Error")
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
        marketCapLabel.text = formatPrice(Double(coin.marketCap) ?? 0.00)
        volumeLabel.text = formatPrice(Double(coin.the24HVolume) ?? 0.00)
        setPrice(allTimeHighLabel, price: coin.allTimeHigh.price, currencySymbol: currencySymbol)
        noOfMarketsLabel.text = String(coin.numberOfMarkets)
        self.title = coin.name
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
        chartView.xLabels = []
       // chartView.yLabels  =
        
    }
    private func historyAPICall(_ a: String) {
        CoinAPI.getCoinHistory(timePeriod: a, currencyUuid: currencyId, uuid: singleCoinId, completion: historyHandler(success:error:))
    }
    
    @IBAction func threehAction(_ sender: Any) {
       historyAPICall("3h")
    }
    @IBAction func dayAction(_ sender: Any) {
        historyAPICall("24h")
    }
    @IBAction func sevenDayAction(_ sender: Any) {
        historyAPICall("7d")
    }
    @IBAction func thrityDayAction(_ sender: Any) {
        historyAPICall("30d")
    }
    @IBAction func threeMonthAction(_ sender: Any) {
        historyAPICall("3m")
    }
    @IBAction func oneYearAction(_ sender: Any) {
        historyAPICall("1y")
    }
    
}

