//
//  ViewController.swift
//  Uber Chef
//
//  Created by Aleksander Stefanovic on 2017-08-21.
//  Copyright © 2017 Aleksander Stefanovic. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ResultController: UIViewController {
    
    let cellIdentifier = "Cell"
    var searchText = ""
    var chefs: [NSManagedObject] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("FINAL Chefs are ", chefs);
        tableView.register(UITableViewCell.self,
                                  forCellReuseIdentifier: cellIdentifier)
    }
    
    func getChefs () {
        let gordonName = "Gordon Ramsay"
        let hestonName = "Heston Blumenthal"
        let massimoName = "Massimo Bottura"
        let reneName = "René Redzepi"
        
        if (searchText.characters.count == 0) {
            self.save (name: gordonName, phone: "613-555-0108", lat: 37.792961, lng: -122.413175, email: "aleks.stefanovic101@gmail.com")
            self.save (name: hestonName, phone: "613-555-0195", lat: 37.803962, lng: -122.403175, email: "hestonblumenthal@uberchef.com")
            self.save (name: massimoName, phone: "613-555-0116", lat: 37.782963, lng: -122.433175, email: "massimobottura@uberchef.com")
            self.save (name: reneName, phone: "613-555-0123", lat: 37.772964, lng: -122.393175, email: "reneredzepi@uberchef.com")
        }
        else if gordonName.range(of:searchText) != nil {
            self.save (name: gordonName, phone: "613-555-0108", lat: 37.792961, lng: -122.413175, email: "aleks.stefanovic101@gmail.com")
        }
        else if hestonName.range(of:searchText) != nil {
            self.save (name: hestonName, phone: "613-555-0195", lat: 37.803962, lng: -122.403175, email: "hestonblumenthal@uberchef.com")
        }
        else if massimoName.range(of:searchText) != nil {
            self.save (name: massimoName, phone: "613-555-0116", lat: 37.782963, lng: -122.433175, email: "massimobottura@uberchef.com")
        }
        else if reneName.range(of:searchText) != nil {
            self.save (name: reneName, phone: "613-555-0123", lat: 37.772964, lng: -122.393175, email: "reneredzepi@uberchef.com")
        }
    }
    
    func save(name: String, phone: String, lat: Float, lng: Float, email: String) {
        //print("saving chef");
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "Chef",
                                       in: managedContext)!
        
        let chef = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        chef.setValue(name, forKeyPath: "name")
        chef.setValue(phone, forKeyPath: "phone")
        chef.setValue(lat, forKeyPath: "lat")
        chef.setValue(lng, forKeyPath: "lng")
        chef.setValue(email, forKeyPath: "email")
        
        do {
            try managedContext.save()
            chefs.append(chef)
            //print("Chefs are ", chefs);
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Chef")
        
        do {
            print("fetching chefs and loading")
            chefs = try managedContext.fetch(fetchRequest)
            
            chefs = [];
            getChefs();
            self.tableView.reloadData()
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ResultController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return chefs.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let chef = chefs[indexPath.row]
            let cell =
                tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                              for: indexPath)
            cell.textLabel?.text = chef.value(forKeyPath: "name") as? String
            return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Chef selected")

        let myVC = storyboard?.instantiateViewController(withIdentifier: "ChefController") as! ChefController
        let chef = chefs[indexPath.row]
        myVC.chefNameStr = chef.value(forKeyPath: "name") as! String
        myVC.chefPhoneStr = chef.value(forKeyPath: "phone") as! String
        myVC.chefEmailStr = chef.value(forKeyPath: "email") as! String
    
        navigationController?.pushViewController(myVC, animated: true)
    }
}

