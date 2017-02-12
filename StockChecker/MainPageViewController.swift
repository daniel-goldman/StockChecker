//
//  MainPageViewController.swift
//  StockChecker
//
//  Created by Daniel on 1/21/17.
//  Copyright © 2017 Daniel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    // Instantiate the delegate layer to interact with Core Data
    lazy var dataController = DataController()
    
    // Deserialized Stock Objects
    var stockObjects = [StockObject]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "stockObjectView")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewDidAppear(true)
        
        // get the latest data
        stockObjects = dataController.load()!
        
        // now we need to display/update it
        self.tableView.reloadData()
    }

    @IBAction func openAddPage(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "openAddPage", sender: self)
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        self.performSegue(withIdentifier: "showStockDetails", sender: self)
//    }
    
    // get number of rows to display.  This is the number of stock objects retrieved by the DataController.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return (dataController.load()?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockTableViewCell") as! StockTableViewCell
        cell.stockTickerLabel.text = stockObjects[indexPath.item].stockTicker
        
        // Async call to get and set the latest stock price
        Alamofire.request("http://dev.markitondemand.com/MODApis/Api/v2/Quote/json?symbol=" + cell.stockTickerLabel.text!, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            let json = JSON(response.result.value!)

            cell.lastPriceLabel.text = json["LastPrice"].stringValue
            
            // Add one to poll count and save to Core Data.
            let d : [StockObject]? = self.dataController.load()
            for stockObject in d! {
                if(stockObject.stockTicker == cell.stockTickerLabel.text) {
                    stockObject.pollCountSinceCreated = String(Int(stockObject.pollCountSinceCreated)! + 1)
                    self.dataController.update(stockObject)
                    break;
                }
            }
        }
        
        cell.lowPriceLabel.text = stockObjects[indexPath.item].lowPrice
        cell.highPriceLabel.text = stockObjects[indexPath.item].highPrice

        return cell
    }
    
    // enables the cells to be edited (deleted)
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            // delete the stock
            dataController.delete(stockObjects[indexPath.row].stockTicker!)
            
            // remove the corresponding stock from the table
            stockObjects.remove(at: indexPath.row)
            
            self.tableView.reloadData()
        }
    }
}

