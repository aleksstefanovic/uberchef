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
    
    @IBAction func exitNav(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        navigationController?.pushViewController(myVC, animated: true)
    }
    
    @IBAction func searchChefs(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "ResultController") as! ResultController
        myVC.searchText = searchText.text!
        navigationController?.pushViewController(myVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

