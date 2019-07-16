//
//  SwitchTableViewCell.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 16/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class SwitchTableViewCell : UITableViewCell{
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var onOff: UISwitch!
    public var onOffChanged:((UISwitch) -> Void)?
    
    
    
    public override func awakeFromNib() {
        onOff.onTintColor = GeneralProperties.blueColor
    }
    
    @IBAction func onOffOccur(_  sender: UISwitch){
        if let onOffChanged = onOffChanged{
            onOffChanged(sender)
        }
    }
}
