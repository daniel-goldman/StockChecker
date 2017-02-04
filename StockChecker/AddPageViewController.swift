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
    
    var stockObject = StockObject()
	
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    @IBAction func closeAddPage(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addStock(_ sender: UIButton) {
		
        dataController.save(stockObject)
        
        closeAddPage(sender)
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
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
