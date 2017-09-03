//
//  ViewController.swift
//  Uber Chef
//
//  Created by Aleksander Stefanovic on 2017-08-21.
//  Copyright © 2017 Aleksander Stefanovic. All rights reserved.
//

import UIKit

class NavController: UIViewController {
    @IBOutlet weak var searchText: UITextField!
    
    @IBAction func searchChefs(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "ResultController") as! ResultController
        myVC.stringPassed = searchText.text!
        navigationController?.show(myVC, sender: NavController.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

