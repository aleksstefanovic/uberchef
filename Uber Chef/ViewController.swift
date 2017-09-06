//
//  ViewController.swift
//  Uber Chef
//
//  Created by Aleksander Stefanovic on 2017-08-21.
//  Copyright © 2017 Aleksander Stefanovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func openNav(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "NavController") as! NavController
        navigationController?.pushViewController(myVC, animated: true)
    }
    
    @IBAction func showNearbyChefs(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "MapController") as! MapController
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

