//
//  GroceryListViewController.swift
//  groceryListTest
//
//  Created by anydo on 02/04/2018.
//  Copyright © 2018 anydo. All rights reserved.
//

import UIKit

class GroceryCell : UICollectionViewCell {
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemWeightLabel: UILabel!
    @IBOutlet weak var itemColourView: UIView!
    
}

class GroceryListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var presenter:GroceryListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = GroceryListPresenter()
        presenter.groceryListVC = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeLayoutPressed(_ sender: UIButton) {
        
    }
    
    func refreshCollectionView() {
        collectionView.reloadData()
    }
}

extension GroceryListViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "groceryCell", for: indexPath)
        guard let groceryCell = cell as? GroceryCell else { return cell }
        guard let item = presenter.itemForIndex(index: indexPath.item) else { return cell }
        groceryCell.itemNameLabel.text = item.itemName
        groceryCell.itemWeightLabel.text = "\(item.itemWeight)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension GroceryListViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if presenter.layout == .list {
            return CGSize(width: 250, height: 50)
        } else {
            return CGSize(width: 100, height: 50)
        }
    }
}