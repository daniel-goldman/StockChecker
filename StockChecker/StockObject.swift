//
//  StockObject.swift
//  StockChecker
//
//  Created by Daniel on 1/21/17.
//  Copyright © 2017 Daniel. All rights reserved.
//

class StockObject {
    
	var stockTicker: String?
    var lowPrice: String?
    var highPrice: String?
	var creationDate: String?
	var pollCountSinceCreated = "0"
    var lastPollData = LastPollData()

    init() {
        
    }
	
	init(stockTicker: String, lowPrice: String, highPrice: String, pollCountSinceCreated: String, creationDate: String) {
        self.stockTicker = stockTicker
        self.lowPrice = lowPrice
        self.highPrice = highPrice
		self.creationDate = creationDate
		self.pollCountSinceCreated = pollCountSinceCreated
        self.lastPollData = LastPollData()
    }
}
