//
//  AddPageViewController.swift
//  StockChecker
//
//  Created by Daniel on 1/21/17.
//  Copyright © 2017 Daniel. All rights reserved.
//

import UIKit
import CoreData

class AddPageViewController: UIViewController {

    var stock: String?
    var lowPrice: Float?
    var highPrice: Float?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    @IBAction func closeAddPage(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addStock(_ sender: UIButton) {
        
        print("added stock!")
        
        closeAddPage(sender)
    }

    @IBAction func getStockTicker(_ sender: UITextField?) {

        stock = sender?.text
    }
    
    @IBAction func setLowPrice(_ sender: UITextField?) {

        lowPrice = Float((sender?.text)!)
    }
    
    @IBAction func setHighPrice(_ sender: UITextField?) {
        
        highPrice = Float((sender?.text)!)
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
