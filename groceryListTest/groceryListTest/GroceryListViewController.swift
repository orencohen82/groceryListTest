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
    private let transition = GroceryItemAnimator()
    private var tappedCellFrame = CGRect.zero
    
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
        presenter.changeLayout()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func refreshCollectionView() {
        collectionView.reloadData()
    }
    
    func newItemAddedAtIndex(index:Int) {
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: [IndexPath(item: index, section: 0)])
        }, completion: { (finished) in
            
        })
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
        
        groceryCell.itemNameLabel.text = item.name
        groceryCell.itemWeightLabel.text = item.weight
        groceryCell.itemColourView.backgroundColor = UIColor().HexToColor(hexString: item.bagColor, alpha: 1.0)
        groceryCell.itemColourView.layer.cornerRadius = groceryCell.itemColourView.frame.size.width/2
        
        return groceryCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Open fullscreen item view
        guard let item = presenter.itemForIndex(index: indexPath.item) else { return }
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let itemFullscreenVC = storyboard.instantiateViewController(withIdentifier: "itemFullscreenVC") as? GroceryItemFullscreenViewController else { return }
        
        if let tappedCell = collectionView.cellForItem(at: indexPath) {
            tappedCellFrame = tappedCell.superview?.convert(tappedCell.frame, to: nil) ?? CGRect.zero
        }
        
        itemFullscreenVC.item = item
        itemFullscreenVC.transitioningDelegate = self
        present(itemFullscreenVC, animated: true, completion: nil)
    }
}

extension GroceryListViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if presenter.getLayout() == .list {
            return CGSize(width: 250, height: 50)
        } else {
            return CGSize(width: 100, height: 50)
        }
    }
}

extension GroceryListViewController : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard presented is GroceryItemFullscreenViewController else { return nil }
        
        transition.originFrame = tappedCellFrame
        transition.presenting = true
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}
