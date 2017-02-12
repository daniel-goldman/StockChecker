//
//  BackgroundBehaviorController.swift
//  StockChecker
//
//  Created by Daniel on 2/4/17.
//  Copyright © 2017 Daniel. All rights reserved.
//

import Alamofire
import SwiftyJSON
import SwiftDate

class BackgroundBehaviorController {
    
    // gets the array of stocks exactly once
    let stockObjects: [StockObject]!
    let dataController = DataController()
    let notificationController = NotificationController()
    let serverUrlAsString = "http://dev.markitondemand.com/MODApis/Api/v2/Quote/json?symbol="
    let alamoFireManager: SessionManager!
    var stockCounter: Int = 0
    
    init() {
        
        stockObjects = dataController.load()!
        notificationController.setDefaults()
        notificationController.setTitle("Stock Price Alert")
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 20 // seconds
        configuration.timeoutIntervalForRequest = 20 // seconds
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    // Polls the server for each latest stock price and sets each latest price accordingly in this class's stock objects.
    // Saves the last results to Core Data.
    func pollServerForLastStockPrices(_ completionHandler: ((UIBackgroundFetchResult) -> Void)!) {
        
        if(stockObjects.count == 0) {
            print("finished, no stocks found")
            completionHandler(UIBackgroundFetchResult.newData)
            return
        }
        
        var stockAlerts = [String]()
        
        for stockObject in stockObjects {
            
            alamoFireManager.request(serverUrlAsString + stockObject.stockTicker!, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
                
                let json = JSON(response.result.value!)
                
                // set this stock's last price
                stockObject.lastPollData.lastPrice = json["LastPrice"].stringValue
                stockObject.lastPollData.timestamp = DateInRegion(absoluteDate: Date.init()).string()
                stockObject.lastPollData.result = response.result.description
                
                self.dataController.update(stockObject)
                
                let lastPrice: Float = Float(stockObject.lastPollData.lastPrice!)!
                let lowPrice: Float = Float(stockObject.lowPrice!)!
                let highPrice: Float = Float(stockObject.highPrice!)!
                
                if(lastPrice < lowPrice || lastPrice > highPrice) {
                    
                    stockAlerts.append(stockObject.stockTicker!)
                }
                
                self.stockCounter += 1
                
                // If end reached, notify the user and call completion handler.
                if(self.stockCounter == self.stockObjects.count) {
                    if(!stockAlerts.isEmpty) {
                        var count: Int = 0
                        var stocksToAlert = String()
                        for stockAlert in stockAlerts {
                            
                            if(count != 0) {
                                stocksToAlert.append(", ")
                            }
                            stocksToAlert.append(stockAlert)
                            count += 1
                        }
                        if(stockAlerts.count == 1) {
                            self.notificationController.setBody("The price on \(stocksToAlert) is skyrocketing or plummeting!")
                        } else {
                            self.notificationController.setBody("The prices on \(stocksToAlert) are skyrocketing or plummeting!")
                        }
                        self.notificationController.fire()
                    }
                    completionHandler(UIBackgroundFetchResult.newData)
                    return
                }
            } // end async callback
        }
    }
}
