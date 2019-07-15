//
//  LevelSelectionCollectionViewController.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 15/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
public class LevelSelectionCollectionViewController : UICollectionViewController{
    var levels:[Level] = []
    
    public override func viewDidLoad() {
        levels = ModelController.shared().getLevels()
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
            lvCell.lblLevel.text = "\(levels[indexPath.row].id)"
            lvCell.completionBadge.borderColor = GeneralProperties.lightblueColor
            switch levels[indexPath.row].completion{
            case 1:
                lvCell.completionBadge.fillColor = GeneralProperties.bronzeColor
                break
            case 2:
                lvCell.completionBadge.fillColor = GeneralProperties.silverColor
                break
            case 3:
                lvCell.completionBadge.fillColor = GeneralProperties.goldColor
                break
            default:
                lvCell.completionBadge.fillColor = .white
                break
            }
            cell = lvCell
        }
        
        return cell
    }
}
