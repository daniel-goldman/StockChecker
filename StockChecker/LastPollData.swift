//
//  LastPoll.swift
//  StockChecker
//
//  Created by Daniel on 1/21/17.
//  Copyright © 2017 Daniel. All rights reserved.
//

class LastPollData {
    
    var timestamp: String!
    var result: String!
    
    init() {
        
    }
    
    init(timestamp: String?, result: String?) {
        
        self.timestamp = timestamp
        self.result = result
    }
}
