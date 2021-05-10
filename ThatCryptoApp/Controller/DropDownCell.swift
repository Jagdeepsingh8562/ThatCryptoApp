//
//  MenuItemCell.swift
//  ThatCryptoApp
//
//  Created by Jagdeep Singh on 10/05/21.
//

import UIKit
import DropDown
class MenuItemCell: DropDownCell {
    @IBOutlet weak var symbolAndSignLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        symbolAndSignLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
