//
//  LastPoll.swift
//  StockChecker
//
//  Created by Daniel on 1/21/17.
//  Copyright © 2017 Daniel. All rights reserved.
//

class LastPollData {
    
    var lastPrice: String?
    var result: String?
    var timestamp: String?
    
    init() {
        
    }
    
    init(lastPrice: String?, result: String?, timestamp: String?) {
        
        self.lastPrice = lastPrice
        self.timestamp = timestamp
        self.result = result
    }
}
