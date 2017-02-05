//
//  StockObject.swift
//  StockChecker
//
//  Created by Daniel on 1/21/17.
//  Copyright © 2017 Daniel. All rights reserved.
//

import Gloss

class StockObject: Decodable {
    
	var stockTicker: String?
    var lowPrice: String?
    var highPrice: String?
    var lastPollData = LastPollData()

    init() {
        
    }
	
	// Constructor using Gloss library to get stock ticker name from JSON
	required init(json: JSON) {
		self.lastPollData.lastPrice = "LastPrice" <~~ json
	}
	
	// method to set the latest price.  Not ideal, logic should be moved to a separate class in the future.
	func setPollDataLastPrice(json: JSON) {
		
		let lastPriceAsFloat: Float = Decoder.decode(key: "LastPrice")(json)!
		self.lastPollData.lastPrice = String(lastPriceAsFloat)
	}
	
    init(stockTicker: String, lowPrice: String, highPrice: String) {
        self.stockTicker = stockTicker
        self.lowPrice = lowPrice
        self.highPrice = highPrice
        self.lastPollData = LastPollData()
    }
}
