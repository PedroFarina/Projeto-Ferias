//
//  LevelSelectionCollectionViewController.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 15/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
public class LevelSelectionCollectionViewController : UICollectionViewController{
    private var levels:[Level] = []
    public var selectionDelegate:LevelSelectedDelegate?
    
    public override func viewDidLoad() {
        levels = ModelController.shared().getLevels()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        for c in collectionView.visibleCells{
            c.awakeFromNib()
        }
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
            lvCell.lblLevel.text = "\(levels[indexPath.row].id + 1)"
            lvCell.completionBadge.borderColor = GeneralProperties.lightblueColor
            if indexPath.row != 0{
                lvCell.isHidden = levels[indexPath.row - 1].completion == 0
            }
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
    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectionDelegate?.levelSelected(levels[indexPath.row])
    }
}
