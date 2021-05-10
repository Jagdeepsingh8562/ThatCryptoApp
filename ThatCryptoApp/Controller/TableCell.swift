//
//  TableCell.swift
//  ThatCryptoApp
//
//  Created by Jagdeep Singh on 10/05/21.
//

import Foundation
import UIKit
class TableCell: UITableViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    
    override func awakeFromNib() {
       super.awakeFromNib()
       //custom logic goes here
        
    }
    func setPrice(_ a: String,currencySymbol: String) {
        let doubleValue = Double(a)!
        priceLabel.text = currencySymbol + String(format: "%.3f", doubleValue)
    }
    func setChange(_ a : String?)  {
        guard let a = a  else {
            changeLabel.text = ""
            return
        }
        let doubleValue = Double(a)!
        var arrow: String = ""
        if doubleValue < 0 {
            changeLabel.textColor = .red
            arrow = "\u{2193}"
        }
        else {
            changeLabel.textColor = .systemGreen
            arrow = "\u{2191}"
        }
        changeLabel.text = arrow + String(format: "%.2f", doubleValue) + "%"
    }
    
}
