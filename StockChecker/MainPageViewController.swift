//
//  MainPageViewController.swift
//  StockChecker
//
//  Created by Daniel on 1/21/17.
//  Copyright © 2017 Daniel. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var dataController = DataController()
    
    var stockObjects: [StockObject]?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "stockObjectView")
        tableView.delegate = self
        tableView.dataSource = self
        
        // dataController.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewDidAppear(true)
        stockObjects = dataController.load() // get the latest data
        
        // now we need to display/update it
        self.tableView.reloadData()
    }

    @IBAction func openAddPage(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "openAddPage", sender: self)
    }
    
    // get number of rows to display.  This is the number of stock objects retrieved by the DataController.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(dataController.load()?.count)
        
        return (dataController.load()?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockObjectView")! as UITableViewCell
        cell.textLabel?.text = stockObjects?[indexPath.item].stockTicker
            //+ (stockObjects?[indexPath.item].lowPrice?)! + (stockObjects?[indexPath.item].highPrice?)!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {

            dataController.delete(stockObjectToDeleteByTicker: "O")
            self.tableView.reloadData()
        }
    }
}

