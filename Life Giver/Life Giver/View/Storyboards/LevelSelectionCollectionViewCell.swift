//
//  LevelSelectionCollectionViewCell.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 15/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class LevelSelectionCollectionViewCell : UICollectionViewCell{
    @IBOutlet var lblLevel: UILabel!
    @IBOutlet var completionBadge: ShapeView!
    
    public override func awakeFromNib() {
        layer.borderWidth = 1
        layer.borderColor = GeneralProperties.lightblueColor.cgColor
        layer.cornerRadius = 20
        
        lblLevel.textColor = GeneralProperties.lightblueColor
    }
}
