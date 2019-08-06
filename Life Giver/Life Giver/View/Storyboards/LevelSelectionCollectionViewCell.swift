//
//  LevelSelectionCollectionViewCell.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 15/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class LevelSelectionTableViewCell : UITableViewCell{
    @IBOutlet var lblLevel: UILabel!
    @IBOutlet var completionBadge: ShapeView!
    @IBOutlet var card: UIView!
    public var completion:Int16 = 0
    
    func getColorCell() -> UIColor{
        switch completion {
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
    
    public override func awakeFromNib() {
        card.layer.borderWidth = 1
        card.layer.borderColor = GeneralProperties.lightblueColor.cgColor
        card.layer.cornerRadius = 20
        
        lblLevel.textColor = GeneralProperties.lightblueColor
        completionBadge.fillColor = getColorCell()
    }
}
