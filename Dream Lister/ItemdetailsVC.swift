//
//  ItemdetailsVC.swift
//  Dream Lister
//
//  Created by Fahad Rehman on 12/11/16.
//  Copyright © 2016 Codecture. All rights reserved.
//

import UIKit
import CoreData
class ItemdetailsVC: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource{
    @IBOutlet weak var titleLbl: CustomTextField!

    @IBOutlet weak var priceLbl: CustomTextField!
    @IBOutlet weak var detailsLbl: CustomTextField!
    
    @IBOutlet weak var storePicker: UIPickerView!
    
    var stores = [Store]()
    var itemToEdit : Item?
    var item : Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
            
            storePicker.dataSource = self
            storePicker.delegate = self
            
//            let store = Store(context: context)
//            store.name = "Cash n Carry"
//            let store2 = Store(context: context)
//            store2.name = "iCity"
//            let store3 = Store(context: context)
//            store3.name = "Honda Isb"
//            let store4 = Store(context: context)
//            store4.name = "Amazon"
//            let store5 = Store(context: context)
//            store5.name = "eBay"
//            
//            ad.saveContext()
            
            getStores()
            
            if itemToEdit != nil {
                updateData()
            }
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let storename = stores[row]
        return storename.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func getStores () {
        
        let fetchrequest : NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            self.stores = try context.fetch(fetchrequest)
            self.storePicker.reloadAllComponents()
        } catch {
            
        }
    }
    
    
    @IBAction func saveItem(_ sender: Any) {
        
        
        
        if itemToEdit == nil {
            
            item = Item(context: context)
            
        } else {
            
            item = itemToEdit
            
        }
        
        if let title = titleLbl.text {
            item.title = title
        }
        
        if let price = priceLbl.text {
            item.price = (price as NSString).doubleValue
        }
        
        if let detail = detailsLbl.text {
            item.details = detail
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent : 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
        
    }

    func updateData() {
        
        
        if let item = itemToEdit {
            titleLbl.text = item.title
            priceLbl.text = "\(item.price)"
            detailsLbl.text = item.details
            
            if let store = item.toStore {
            var index = 0
            repeat {
                let s = stores[index]
                if s.name == store.name {
                    storePicker.selectRow(index, inComponent: 0, animated: false)
                    break
                }
                index += 1
            } while(index < stores.count)
        }
    }
    
    }
}
























