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
    
    var searchText = ""
    var chefs: [NSManagedObject] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("FINAL Chefs are ", chefs);
        tableView.register(UITableViewCell.self,
                                  forCellReuseIdentifier: "Cell")
        getChefs();
        print ("Chefs are ", chefs);
        print("FINISHED GETTING ALL CHEFS");
        self.tableView.reloadData()
    }
    
    func getChefs () {
        print("GETTING CHEFS");
        self.save (name: "Gordon Ramsay", phone: "613-555-0108")
        self.save (name: "Heston Blumenthal", phone: "613-555-0195")
        self.save (name: "Massimo Bottura", phone: "613-555-0116")
        self.save (name: "René Redzepi", phone: "613-555-0123")
    }
    
    func save(name: String, phone: String) {
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
            chefs = try managedContext.fetch(fetchRequest)
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
        print ("Chef count is ", chefs.count);
        return chefs.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            print ("adding to table")
            let chef = chefs[indexPath.row]
            let cell =
                tableView.dequeueReusableCell(withIdentifier: "Cell",
                                              for: indexPath)
            cell.textLabel?.text = chef.value(forKeyPath: "name") as? String
            print("Returning table cell")
            return cell
    }
}

