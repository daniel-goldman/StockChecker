//
//  StockTableViewCell.swift
//  StockChecker
//
//  Created by Daniel on 2/3/17.
//  Copyright © 2017 Daniel. All rights reserved.
//

import UIKit

class StockTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stockTickerLabel: UILabel!
    @IBOutlet weak var lowPriceLabel: UILabel!
    @IBOutlet weak var highPriceLabel: UILabel!
    @IBOutlet weak var lastPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
