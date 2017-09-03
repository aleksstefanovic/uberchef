//
//  ViewController.swift
//  Uber Chef
//
//  Created by Aleksander Stefanovic on 2017-08-21.
//  Copyright © 2017 Aleksander Stefanovic. All rights reserved.
//

import UIKit

class ResultController: UIViewController {
    @IBOutlet weak var testLabel: UILabel!
    var stringPassed = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.text = stringPassed
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

