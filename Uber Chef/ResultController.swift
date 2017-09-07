//
//  ViewController.swift
//  Uber Chef
//
//  Created by Aleksander Stefanovic on 2017-08-21.
//  Copyright © 2017 Aleksander Stefanovic. All rights reserved.
//

import UIKit
import CoreData

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
        self.save (name: "Gordon Ramsay", phone: "613-555-0108", lat: 37.792961, lng: -122.413175)
        self.save (name: "Heston Blumenthal", phone: "613-555-0195", lat: 37.803962, lng: -122.403175)
        self.save (name: "Massimo Bottura", phone: "613-555-0116", lat: 37.782963, lng: -122.433175)
        self.save (name: "René Redzepi", phone: "613-555-0123", lat: 37.772964, lng: -122.393175)
    }
    
    func save(name: String, phone: String, lat: Float, lng: Float) {
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
            print ("Chefs are ", chefs);
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

extension ResultController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        //print ("Chef count is ", chefs.count);
        return chefs.count
    }
    
    // MARK: - UITableViewDataSource
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(chefs[indexPath.row])
    }
}

