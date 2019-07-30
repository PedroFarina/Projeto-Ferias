//
//  ConfigurationTableViewController.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 16/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class ConfigurationTableViewController : UITableViewController{
    private var colorables:[UIView] = []
    private static var defaults = UserDefaults.standard
    
    public override func viewDidLoad() {
        tableView.tableFooterView = UIView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        for view in colorables{
            view.awakeFromNib()
        }
        guard let navigationController = navigationController else{
            return
        }
        
        navigationController.navigationBar.tintColor = GeneralProperties.blueColor
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Sons"
        }
        else{
            return " "
        }
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 2
        }
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = UITableViewCell()
        if indexPath.section == 0{
            if let soundCell = tableView.dequeueReusableCell(withIdentifier: "soundCell") as? SliderTableViewCell{
                if indexPath.row == 0{
                    soundCell.lblTitle.text = "SFX"
                    soundCell.slider.value = Float(GeneralProperties.SFXValue)
                    soundCell.sliderChanged = {
                     (slider) in
                        GeneralProperties.SFXValue = Int(slider.value)
                    }
                }
                else{
                    soundCell.lblTitle.text = "BGM"
                    soundCell.slider.value = Float(GeneralProperties.BGMValue)
                    soundCell.sliderChanged = {
                        (slider) in
                        GeneralProperties.BGMValue = Int(slider.value)
                    }
                }
                colorables.append(soundCell.slider)
                cell = soundCell
            }
        }
        else{
            if let switchCell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as? SwitchTableViewCell{
                switchCell.lblTitle.text = "Daltonismo"
                switchCell.onOff.isOn = GeneralProperties.DaltonismoValue
                switchCell.onOffChanged = {
                    (uiSwitch) in
                    GeneralProperties.DaltonismoValue = uiSwitch.isOn
                }
                colorables.append(switchCell.onOff)
                cell = switchCell
            }
        }
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43.5
    }
}
