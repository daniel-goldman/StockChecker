//
//  StockObject.swift
//  StockChecker
//
//  Created by Daniel on 1/21/17.
//  Copyright © 2017 Daniel. All rights reserved.
//

import Foundation

class StockObject {
    
    var stockTicker: String?
    var lowPrice: String?
    var highPrice: String?
    var lastPollData = LastPollData()

    init() {
        
    }
	
    init(stockTicker: String, lowPrice: String, highPrice: String) {
        self.stockTicker = stockTicker
        self.lowPrice = lowPrice
        self.highPrice = highPrice
        self.lastPollData = LastPollData()
    }
}
