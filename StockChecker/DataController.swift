//
//  DataController.swift
//  StockChecker
//
//  Created by Daniel on 1/29/17.
//  Copyright © 2017 Daniel. All rights reserved.
//

import UIKit
import CoreData

class DataController {
    
    func save(stockObject: StockObject) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			return
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let entity = NSEntityDescription.entity(forEntityName: "StockEntity",
                                       in: managedContext)!
        
        let stockManagedObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // 3
        stockManagedObject.setValue(stockObject.stockTicker, forKeyPath: "stockTicker")
		stockManagedObject.setValue(stockObject.lowPrice, forKeyPath: "lowPrice")
		stockManagedObject.setValue(stockObject.highPrice, forKeyPath: "highPrice")

        // 4
        do {
            try managedContext.save()

        } catch let error as NSError {
            print("\nCould not save. \(error), \(error.userInfo)\n")
        }
    }
}
