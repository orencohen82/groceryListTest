//
//  GroceryListPresenter.swift
//  groceryListTest
//
//  Created by anydo on 02/04/2018.
//  Copyright © 2018 anydo. All rights reserved.
//

import UIKit
import Starscream

enum GroceryListLayout {
    case list
    case grid
}

class GroceryListPresenter: NSObject {
    
    var itemsArray:[GroceryItem]
    var layout:GroceryListLayout
    weak var groceryListVC:GroceryListViewController?
    var socket:WebSocket?
    
    override init() {
        itemsArray = [GroceryItem]()
        layout = .list
        super.init()
        
        let url = URL(string: "ws://superdo-groceries.herokuapp.com/receive")
        socket = WebSocket(url: url!)
        socket?.delegate = self
        socket?.connect()
    }
    
    func numberOfItems() -> Int {
        return itemsArray.count
    }
    
    func itemForIndex(index:Int) -> GroceryItem? {
        guard index < itemsArray.count else { return nil }
        return itemsArray[index]
    }
}

extension GroceryListPresenter : WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
        print("websocket is connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocket is disconnected: \(error?.localizedDescription)")
        
        
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("got some text: \(text)")
        
        do {
            if let data = text.data(using: .utf8) {
                let decoder = JSONDecoder()
                let item = try decoder.decode(GroceryItem.self, from: data)
                itemsArray.insert(item, at: 0)
                groceryListVC?.refreshCollectionView()
            }
            
        } catch let err {
            print("Err", err)
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("got some data: \(data.count)")
    }
    
    
}
