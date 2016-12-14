//
//  ItemCell.swift
//  Dream Lister
//
//  Created by Fahad Rehman on 12/10/16.
//  Copyright © 2016 Codecture. All rights reserved.
//

import UIKit
import  CoreData

class ItemCell: UITableViewCell {

    
    @IBOutlet weak var thumb: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var details: UILabel!
    
    
    func configureCell(item: Item) {
        title.text = item.title
        price.text = "$\(item.price)"
        details.text = item.details
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    

}
