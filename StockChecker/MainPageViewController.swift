//
//  ViewController.swift
//  StockChecker
//
//  Created by Daniel on 1/21/17.
//  Copyright © 2017 Daniel. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {

    //@IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    @IBAction func openAddPage(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "openAddPage", sender: self)
    }
    
    //@IBAction func unwindToMainPage(sender: UIStoryboardSegue) { }
}

