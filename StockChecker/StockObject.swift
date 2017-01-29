//
//  StockObject.swift
//  StockChecker
//
//  Created by Daniel on 1/21/17.
//  Copyright © 2017 Daniel. All rights reserved.
//

import Foundation

class StockObject {
    
    var stockTicker: String
    var lowPrice: Float
    var highPrice: Float
    var lastPollData: LastPollData

//    init() {
//        
//    }
	
    init(stockTicker: String, lowPrice: Float, highPrice: Float) {
        self.stockTicker = stockTicker
        self.lowPrice = lowPrice
        self.highPrice = highPrice
        self.lastPollData = LastPollData(timestamp: nil, result: nil)
    }
}
