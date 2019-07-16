//
//  SettingsTableViewCell.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 16/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class SliderTableViewCell : UITableViewCell{
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var slider: UISlider!
    public var sliderChanged:((UISlider) -> Void)?
    
    public override func awakeFromNib() {
        slider.tintColor = GeneralProperties.blueColor
    }
    
    @IBAction func changeOccur(_ sender: UISlider) {
        if let sliderChanged = sliderChanged{
            sliderChanged(sender)
        }
    }
}
