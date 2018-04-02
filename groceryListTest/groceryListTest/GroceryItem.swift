//
//  GroceryItem.swift
//  groceryListTest
//
//  Created by anydo on 02/04/2018.
//  Copyright © 2018 anydo. All rights reserved.
//

import UIKit

class GroceryItem: NSObject {
    var itemName:String
    var itemWeight:Float
    var itemColour:String
    
    init(itemName:String, itemWeight:Float, itemColour:String) {
        self.itemName = itemName
        self.itemWeight = itemWeight
        self.itemColour = itemColour
    }
}
