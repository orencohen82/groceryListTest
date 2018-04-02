//
//  GroceryListPresenter.swift
//  groceryListTest
//
//  Created by anydo on 02/04/2018.
//  Copyright © 2018 anydo. All rights reserved.
//

import UIKit

enum GroceryListLayout {
    case list
    case grid
}

class GroceryListPresenter: NSObject {
    
    var itemsArray:[GroceryItem]
    var layout:GroceryListLayout
    weak var groceryListVC:GroceryListViewController?
    
    override init() {
        itemsArray = [GroceryItem]()
        layout = .list
    }
    
    func numberOfItems() -> Int {
        return itemsArray.count
    }
    
    func itemForIndex(index:Int) -> GroceryItem? {
        guard index < itemsArray.count else { return nil }
        return itemsArray[index]
    }
}
