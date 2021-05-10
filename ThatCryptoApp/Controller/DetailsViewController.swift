//
//  DetailsViewController.swift
//  ThatCryptoApp
//
//  Created by Jagdeep Singh on 08/05/21.
//

import UIKit
import SwiftChart
class DetailsViewController: UIViewController {


    @IBOutlet weak var chartView: Chart!
    let data: [Double] = [0, -2, -2, 3, -3, 4, 1, 0, -1]
    let series = ChartSeries([0, 6.5, 2, 8, 4.1, 7, -3.1, 10, 8])
    var singleCoinId:String = ""
    var currencyId:String?
    var coin:SingleCoin!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CoinAPI.getSingleCoin(currencyUuid: currencyId, uuid: singleCoinId, completion: coinHandler(success:error:))
        
        series.colors.below = ChartColors.redColor()
        series.area = true
        series.colors.above = ChartColors.blueColor()
        chartView.add(series)
        
    }
    func coinHandler(success:Bool,error: Error?) -> Void {
        if success {
            coin = CoinAPI.Const.singleCoin
            navigationController?.navigationBar.topItem?.title = coin.name
        } else {
           showAlert(message: error?.localizedDescription ?? "Something went wrong", title: "Error")
          
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }


}

