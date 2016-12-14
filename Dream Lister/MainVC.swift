//
//  ViewController.swift
//  Dream Lister
//
//  Created by Fahad Rehman on 12/9/16.
//  Copyright © 2016 Codecture. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController , UITableViewDelegate , UITableViewDataSource  , NSFetchedResultsControllerDelegate{

    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    var controller : NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //generateTestData()
        attemptFetch()
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 164
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ItemCell
            configureCell(cell: cell!, indexPath: indexPath as NSIndexPath)
            return cell!
        
    }
    
    func configureCell(cell: ItemCell , indexPath: NSIndexPath){
        
        let item = controller.object(at: (indexPath  as IndexPath))
        cell.configureCell(item: item)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let obj = controller.fetchedObjects , obj.count > 0 {
           let item = obj[indexPath.row]
                
            performSegue(withIdentifier: "update", sender: item)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "update" {
            if let destination = segue.destination as? ItemdetailsVC {
                if let item = sender as? Item {
                    destination.itemToEdit = item
                }
            }
        }
        
    }
    
    func attemptFetch() {
        
        let fetchrequest: NSFetchRequest<Item> = Item.fetchRequest()
        //sorting
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        
        fetchrequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchrequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        self.controller = controller
        do {
           try controller.performFetch()
            
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
            tableView.insertRows(at: [indexPath], with: .fade)
            }
            
            break
        case .update:
           if let indexPath = indexPath {
                
            let cell = tableView.cellForRow(at: indexPath) as? ItemCell
            configureCell(cell: cell!, indexPath: indexPath as NSIndexPath)
           }
            
            break
            
            
       
        case .delete:
                if let indexPath = indexPath {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            break
        case .move:
            
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            
            break
        default:
            print("No switch statments were used")
            
        }
    }
    
    
    func generateTestData() {
        let item = Item(context: context)
        item.title = "Macbook Pro 2016"
        item.price = 2000
        item.details = "Really looking forward to buying this new macbook pro. Hopefully soon."
        
        let item2 = Item(context: context)
        item2.title = "New Civiv 2016"
        item2.price = 28000
        item2.details = "Really looking forward to buying this new model. Hopefully soon."
        
        ad.saveContext()
    }

}



























