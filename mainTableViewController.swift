//
//  mainTableViewController.swift
//  listApp
//
//  Created by Emily on 2/1/18.
//  Copyright © 2018 Emily. All rights reserved.
//

import UIKit
import CoreData

class mainTableViewController: UITableViewController, ViewControllerDelegate {
    
    
    func savelist(by controller: secondViewController, firstName: String, lastName: String, phone: String, at indexPath: NSIndexPath?) {
        if let ip = indexPath {
            let item = tasks[ip.row]
            item.firstName = firstName
            item.lastName = lastName
            item.phone = phone
        }
            
        else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "Info", into: managedObjectContext) as! Info
            item.firstName = firstName
            item.lastName = lastName
            item.phone = phone
            tasks.append(item)
        }
        
        do{
            try managedObjectContext.save()
        }
        catch{
            print("\(error)")
        }
        dismiss(animated: true, completion: nil)
        fetchAllItems()
        tableView.reloadData()
    }
    
    
    var tasks = [Info]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        fetchAllItems()
        tableView.reloadData()
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    func fetchAllItems(){
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Info")
        do {
            let results = try managedObjectContext.fetch(itemRequest)
            tasks = results as! [Info]
          
        } catch {
            print("\(error)")
        }

        
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSegue" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! detailViewController

            if ((sender as? IndexPath) != nil) {
                let ip = sender as! NSIndexPath
//                controller.indexPath = ip
                controller.showname = tasks[ip.row].firstName
                controller.showlastname = tasks[ip.row].lastName
                controller.showphone = tasks[ip.row].phone
            }

        } else {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! secondViewController
            controller.delegate = self
            
            if ((sender as? IndexPath) != nil) {
                let ip = sender as! NSIndexPath
                controller.indexPath = ip
                controller.firstname = tasks[ip.row].firstName
                controller.lastname = tasks[ip.row].lastName
                controller.phone = tasks[ip.row].phone
                controller.title = "Edit Contact"
        }
        }
    }
    
    //************************* populate the task ************************************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        
        let item = tasks[indexPath.row]
        cell.textLabel?.text = item.firstName! + " " + item.lastName!
        cell.detailTextLabel?.text = item.phone
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController()
        
        let viewButton = UIAlertAction(title: "View", style: .default, handler: { (action) -> Void in
            self.performSegue(withIdentifier: "viewSegue", sender: indexPath)
        })
        
        let editButton = UIAlertAction(title: "edit", style: .default, handler: { (action) -> Void in
            self.performSegue(withIdentifier: "addItemSegue", sender: indexPath)
        })
        
        let  deleteButton = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
            var item : Info?
            item = self.tasks[indexPath.row]
            self.tasks.remove(at: indexPath.row)
            self.self.managedObjectContext.delete(item!)
            
            do {
                try self.managedObjectContext.save()
            }catch{
                print(error)
            }
            tableView.reloadData()
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
        })
        
        
        alertController.addAction(viewButton)
        alertController.addAction(editButton)
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true, completion: nil)
        
    }

}



