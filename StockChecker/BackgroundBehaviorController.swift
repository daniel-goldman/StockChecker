//
//  BackgroundBehaviorController.swift
//  StockChecker
//
//  Created by Daniel on 2/4/17.
//  Copyright © 2017 Daniel. All rights reserved.
//

import Gloss

class BackgroundBehaviorController {
    
    // gets the array of stocks exactly once
    let stockObjects: [StockObject]!
    let dataController = DataController()
    let serverUrlAsString = "http://dev.markitondemand.com/MODApis/Api/v2/Quote/json?symbol="
    
    init() {
    
        stockObjects = dataController.load()!
    }
    
    func pollServerForJson() {
        
        for stockObject in stockObjects {

            let request = URLRequest(url: URL(string: serverUrlAsString + stockObject.stockTicker!)!)
            let task = URLSession.shared.dataTask(with: request) {data, response, error in
            
                let jsonResponse = String(data: data!, encoding: String.Encoding.utf8)
                print(jsonResponse)
            }
            task.resume()
        }
    }
}
