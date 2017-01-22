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
    var lastPoll: LastPollDataObject

    init(stockTicker: String, lowPrice: Float, highPrice: Float, lastPoll: LastPollDataObject) {
        self.stockTicker = stockTicker
        self.lowPrice = lowPrice
        self.highPrice = highPrice
        self.lastPoll = LastPollDataObject(timestamp: nil, result: nil)
    }
    
}
