//
//  BackgroundBehaviorController.swift
//  StockChecker
//
//  Created by Daniel on 2/4/17.
//  Copyright © 2017 Daniel. All rights reserved.
//

import Alamofire
import SwiftyJSON

class BackgroundBehaviorController {
    
    // gets the array of stocks exactly once
    let stockObjects: [StockObject]!
    let dataController = DataController()
    let serverUrlAsString = "http://dev.markitondemand.com/MODApis/Api/v2/Quote/json?symbol="
    let alamoFireManager: SessionManager!
    var stockAlerts = [String]()
    var counter: Int = 0
    
    init() {
        
        stockObjects = dataController.load()!
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 20 // seconds
        configuration.timeoutIntervalForRequest = 20 // seconds
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    // Polls the server for each latest stock price and sets each latest price accordingly in this class's stock objects.
    func pollServerForLastStockPrices(_ completionHandler: ((UIBackgroundFetchResult) -> Void)!) {
        
        for stockObject in stockObjects {
            
            alamoFireManager.request(serverUrlAsString + stockObject.stockTicker!, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
                
                let json = JSON(response.result.value!)
                // set this stock's last price
                stockObject.lastPollData.lastPrice = json["LastPrice"].stringValue
                
                let lastPrice: Float = Float(stockObject.lastPollData.lastPrice!)!
                let lowPrice: Float = Float(stockObject.lowPrice!)!
                let highPrice: Float = Float(stockObject.highPrice!)!
                
                if(lastPrice < lowPrice || lastPrice > highPrice) {
                    
                    self.stockAlerts.append(stockObject.stockTicker!)
                }
                
                self.counter += 1
                
                // If end reached, notify the user and call completion handler.
                if(self.counter == self.stockObjects.count) {
                    // for testing ONLY!
                    //let stock = StockObject(stockTicker: "DIS", lowPrice: "900", highPrice: "1000")
                    //self.dataController.save(stock)
                    // end testing code //
                    completionHandler(UIBackgroundFetchResult.newData)
                }
            } // end async callback
        }
    }
}
