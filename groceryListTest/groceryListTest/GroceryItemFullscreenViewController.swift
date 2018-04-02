//
//  GroceryItemFullscreenViewController.swift
//  groceryListTest
//
//  Created by anydo on 02/04/2018.
//  Copyright © 2018 anydo. All rights reserved.
//

import UIKit

class GroceryItemFullscreenViewController: UIViewController {

    @IBOutlet weak var itemColourView: UIView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemWeightLabel: UILabel!
    
    var item:GroceryItem?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let item = self.item else { return }
        itemNameLabel.text = item.name
        itemWeightLabel.text = item.weight
        itemColourView.backgroundColor = UIColor().HexToColor(hexString: item.bagColor)
        itemColourView.layer.cornerRadius = 15
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
