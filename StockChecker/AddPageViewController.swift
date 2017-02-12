//
//  AddPageViewController.swift
//  StockChecker
//
//  Created by Daniel on 1/21/17.
//  Copyright © 2017 Daniel. All rights reserved.
//

import UIKit

class AddPageViewController: UIViewController {

    lazy var dataController = DataController()
	lazy var alertController = UIAlertController(title: "Alert", message: nil, preferredStyle: .alert)
	lazy var action = UIAlertAction(title: "OK", style: .default, handler: nil)

    var stockObject = StockObject()
	
    override func viewDidLoad() {
        
        super.viewDidLoad()
		alertController.addAction(action)
    }
    
    @IBAction func closeAddPage(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addStock(_ sender: UIButton) {
		
		if(stockObject.stockTicker == nil || (stockObject.stockTicker?.isEmpty)!) {
			
			alertController.message = "Stock field cannot be empty"
			self.present(alertController, animated: true, completion: nil)
		}
		else if(stockObject.lowPrice == nil || (stockObject.lowPrice?.isEmpty)!) {
			alertController.message = "\"Low price\" cannot be empty"
			self.present(alertController, animated: true, completion: nil)
		}
		else if(stockObject.highPrice == nil || (stockObject.highPrice?.isEmpty)!) {
			alertController.message = "\"High price\" cannot be empty"
			self.present(alertController, animated: true, completion: nil)
		}
		else {
			dataController.save(stockObject)
			closeAddPage(sender)
		}
    }

    @IBAction func setStockTicker(_ sender: UITextField?) {
		
		if(sender?.text != nil) {
			stockObject.stockTicker = sender?.text
		}
    }
    
    @IBAction func setLowPrice(_ sender: UITextField?) {

		if(sender?.text != nil) {
			stockObject.lowPrice = (sender?.text)!
		}
    }
    
    @IBAction func setHighPrice(_ sender: UITextField?) {
		if(sender?.text != nil) {
			stockObject.highPrice = (sender?.text)!
		}
    }
}
