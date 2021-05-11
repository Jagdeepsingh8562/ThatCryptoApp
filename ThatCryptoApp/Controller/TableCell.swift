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
    
}
