//
//  GroceryItem.swift
//  groceryListTest
//
//  Created by anydo on 02/04/2018.
//  Copyright © 2018 anydo. All rights reserved.
//

import UIKit

struct GroceryItem: Codable {
    var name:String
    var weight:String
    var bagColor:String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case weight
        case bagColor
    }
    
    init(itemName:String, itemWeight:String, itemColour:String) {
        self.name = itemName
        self.weight = itemWeight
        self.bagColor = itemColour
    }
}
