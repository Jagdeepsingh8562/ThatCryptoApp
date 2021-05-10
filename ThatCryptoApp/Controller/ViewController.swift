//
//  ViewController.swift
//  ThatCryptoApp
//
//  Created by Jagdeep Singh on 08/05/21.
//

import UIKit
import SwiftChart
class ViewController: UIViewController {


    @IBOutlet weak var chartView: Chart!
    let data: [Double] = [0, -2, -2, 3, -3, 4, 1, 0, -1]
    let series = ChartSeries([0, 6.5, 2, 8, 4.1, 7, -3.1, 10, 8])
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        series.colors.below = ChartColors.greenColor()
        series.area = true
        series.colors.above = ChartColors.blueColor()
        chartView.add(series)
        
    }


}

