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
	
	let entityName: String = "StockEntity"
	
    func save(_ stockObject: StockObject) {
        
		// get our reference to the AppDelegate
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			return
		}
		
		// get our managed context from the AppDelegate
		let managedContext = appDelegate.persistentContainer.viewContext
		
        // associate our context to an entity
        let entity = NSEntityDescription.entity(forEntityName: entityName,
                                       in: managedContext)!
		
		let alreadyExists: Bool = checkIfStockAlreadyAdded(stockTicker: stockObject.stockTicker!)!
		
        let stockManagedObject = NSManagedObject(entity: entity, insertInto: managedContext)
		
        //
		if(!alreadyExists) {
			do {
				// set managed object attributes
				stockManagedObject.setValue(stockObject.stockTicker, forKeyPath: "stockTicker")
				stockManagedObject.setValue(stockObject.lowPrice, forKeyPath: "lowPrice")
				stockManagedObject.setValue(stockObject.highPrice, forKeyPath: "highPrice")

				try managedContext.save()

			} catch let error as NSError {
				print("\nCould not save. \(error), \(error.userInfo)\n")
			}
		} else {
			print("Already exists!")
		}
    }
	
	func load() -> [StockObject]? {
		
		var stockManagedObjectList: [NSManagedObject]
		var stockObjectList = [StockObject]()
		
		// get our reference to the AppDelegate
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			return nil
		}
		
		// get our managed context from the AppDelegate
		let managedContext = appDelegate.persistentContainer.viewContext
		
		// fetch request associating with entity name
		let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
		
		do {
			// get the list of managed objects
			stockManagedObjectList = try managedContext.fetch(request)
			for stockManagedObject in stockManagedObjectList {
				
				let stockObject = StockObject()
				
				// perform our update for each attribute
				stockObject.stockTicker = stockManagedObject.value(forKey: "stockTicker") as! String?
				stockObject.lowPrice = stockManagedObject.value(forKeyPath: "lowPrice") as! String?
				stockObject.highPrice = stockManagedObject.value(forKeyPath: "highPrice") as! String?
				stockObject.lastPollData.result = stockManagedObject.value(forKeyPath: "result") as! String?
				stockObject.lastPollData.timestamp = stockManagedObject.value(forKeyPath: "timestamp") as! String?
				
				stockObjectList.append(stockObject)
			}
			
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}
		
		return stockObjectList
	}
	
	func delete(_ stockObjectToDeleteByTicker: String) {
		
		// get our reference to the AppDelegate
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			print("error trying to delete")
			return
		}
		
		// get our managed context from the AppDelegate
		let managedContext = appDelegate.persistentContainer.viewContext
		
		// fetch request associating with entity name
		let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
		
		// uncomment this to delete the correct stock not just any one!
		request.predicate = NSPredicate(format: "stockTicker == %@", stockObjectToDeleteByTicker)
		
		var result = [NSManagedObject]()
		
		// get the managed stock result set to delete.
		do {
			result = try managedContext.fetch(request)
			
		} catch let error as NSError {
			print("\nCould not fetch.\(error), \(error.userInfo)\n")
		}
		
		// delete the first (hopefully EXACTLY one) result in the set.
		managedContext.delete(result[0])

		// delete from our managed context.
		do {
			try managedContext.save()
			
		} catch let error as NSError {
			print("\nCould not delete.\(error), \(error.userInfo)\n")
		}
	}
	
	func checkIfStockAlreadyAdded(stockTicker: String) -> Bool? {
		
		// get our reference to the AppDelegate
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			return nil
		}
		
		// get our managed context from the AppDelegate
		let managedContext = appDelegate.persistentContainer.viewContext
		
		// fetch request associating with entity name
		let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
		
		request.predicate = NSPredicate(format: "stockTicker == %@", stockTicker)
		
		var result: [NSManagedObject]?
		
		// get the managed stock result set to delete.
		do {
			result = try managedContext.fetch(request)
			
		} catch let error as NSError {
			print("\nCould not fetch.\(error), \(error.userInfo)\n")
		}
		
		if(result?.count != 0) {
			return true
		}
		else {
			return false
		}
	}
}
