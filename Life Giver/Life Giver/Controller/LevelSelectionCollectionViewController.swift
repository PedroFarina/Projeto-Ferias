//
//  LevelSelectionCollectionViewController.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 15/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
public class LevelSelectionCollectionViewController : UICollectionViewController, LevelFinishedDelegate{
    private var levels:[Level] = []
    public var selectionDelegate:LevelSelectedDelegate?
    
    public override func viewDidLoad() {
        reloadData()
    }
    
    public func levelFinished(level:Level) {
        levels[Int(level.id)] = level
        let indexPath:IndexPath = IndexPath(item: Int(level.id), section: 0)
        if let cell = collectionView.cellForItem(at: indexPath) as? LevelSelectionCollectionViewCell{
            cell.completionBadge.fillColor = getColorCellFor(completionValue: level.completion)
            if level.id+1 != levels.count{
                collectionView.cellForItem(at: IndexPath(row: Int(level.id + 1), section: 0))?.isHidden = false
            }
            var itemsAt:[IndexPath] = []
            if level.id == GeneralProperties.colorLevelID{
                for i in 0 ..< levels.count{
                    itemsAt.append(IndexPath(item: i, section: 0))
                }
            }
            else{
                itemsAt.append(indexPath)
            }
            collectionView.reloadItems(at: itemsAt)
            //viewDidLayoutSubviews()
            //collectionView.collectionViewLayout.invalidateLayout()
        }
        
    }
    
    func getColorCellFor(completionValue:Int16) -> UIColor{
        switch completionValue {
        case 1:
            return GeneralProperties.bronzeColor
        case 2:
            return GeneralProperties.silverColor
        case 3, 4:
            return GeneralProperties.goldColor
        default:
            return .white
        }
    }
    
    public func reloadData(){
        levels = ModelController.shared().getLevels()
        collectionView.reloadData()
    }
    
    public override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return levels.count
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:UICollectionViewCell = UICollectionViewCell()
        if let lvCell = collectionView.dequeueReusableCell(withReuseIdentifier: "levelCell", for: indexPath) as? LevelSelectionCollectionViewCell{
            let selectedLevel:Level = levels[indexPath.row]
            
            lvCell.lblLevel.text = "\(selectedLevel.id + 1)"
            lvCell.completionBadge.borderColor = GeneralProperties.lightblueColor
            
            if indexPath.row != 0{
                //lvCell.isHidden = levels[indexPath.row - 1].completion == 0
            }
            
            lvCell.completionBadge.fillColor = getColorCellFor(completionValue: selectedLevel.completion)
            cell = lvCell
        }
        return cell
    }
    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectionDelegate?.levelSelected(levels[indexPath.row])
    }
}
