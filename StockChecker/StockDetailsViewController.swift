//
//  StockDetailsViewController.swift
//  StockChecker
//
//  Created by Daniel on 2/11/17.
//  Copyright © 2017 Daniel. All rights reserved.
//

import UIKit

class StockDetailsViewController: UIViewController {
    
    @IBOutlet weak var stockTicker: UILabel!
    
    @IBAction func closeStockDetailsPage(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    var stockObject = StockObject()
    let dataController = DataController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewDidAppear(true)

        let stocks: [StockObject]? = dataController.load()
        for stockObject in stocks! {
            if(stockObject.stockTicker == "AAPL" ) {
                stockTicker.text = stockObject.stockTicker
                self.stockObject = stockObject
                break
            }
        }
    }
}
