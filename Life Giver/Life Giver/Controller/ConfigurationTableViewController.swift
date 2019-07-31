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
        let fView = FooterView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        fView.awakeFromNib()
        fView.lbl.text = Bundle.main.localizedString(forKey: "Footer", value: nil, table: nil)
        tableView.tableFooterView = fView
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        setColors()
        navigationItem.title = Bundle.main.localizedString(forKey: "Configurações", value: nil, table: nil)
    }
    
    public func setColors(){
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
            return Bundle.main.localizedString(forKey: "Sons", value: nil, table: nil)
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
        else if GeneralProperties.colorsUnlocked{
            return 3
        }
        return 2
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = UITableViewCell()
        if indexPath.section == 0{
            if let soundCell = tableView.dequeueReusableCell(withIdentifier: "soundCell") as? SliderTableViewCell{
                if indexPath.row == 0{
                    soundCell.lblTitle.text = Bundle.main.localizedString(forKey: "SFX", value: nil, table: nil)
                    soundCell.slider.value = Float(GeneralProperties.SFXValue)
                    soundCell.sliderChanged = {
                     (slider) in
                        GeneralProperties.SFXValue = Int(slider.value)
                    }
                }
                else{
                    soundCell.lblTitle.text = Bundle.main.localizedString(forKey: "BGM", value: nil, table: nil)
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
            switch indexPath.row{
            case 0:
                if let switchCell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as? SwitchTableViewCell{
                    switchCell.lblTitle.text = Bundle.main.localizedString(forKey: "Curiosidades", value: nil, table: nil)
                    switchCell.onOff.isOn = NotificationHandler.allowed
                    switchCell.onOffChanged = {
                        (uiSwitch) in
                        NotificationHandler.allowed = uiSwitch.isOn
                        NotificationSender.sendNotification()
                    }
                    colorables.append(switchCell.onOff)
                    cell = switchCell
                }
            case 1:
                if GeneralProperties.colorsUnlocked{
                    if let switchCell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as? SwitchTableViewCell{
                        switchCell.lblTitle.text = Bundle.main.localizedString(forKey: "Cores", value: nil, table: nil)
                        switchCell.onOff.isOn = GeneralProperties.hasColors
                        switchCell.onOffChanged = {
                            (uiSwitch) in
                            var animation:UITableView.RowAnimation
                            if uiSwitch.isOn{
                                GeneralProperties.enableColors()
                                animation = .left
                            }
                            else{
                                GeneralProperties.disableColors()
                                animation = .right
                            }
                            self.setColors()
                            tableView.reloadRows(at: tableView.indexPathsForVisibleRows ?? [], with: animation)
                        }
                        colorables.append(switchCell.onOff)
                        cell = switchCell
                    }
                }
                else{
                    fallthrough
                }
            default:
                if let switchCell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as? SwitchTableViewCell{
                    switchCell.lblTitle.text = Bundle.main.localizedString(forKey: "Daltonismo", value: nil, table: nil)
                    switchCell.onOff.isOn = GeneralProperties.DaltonismoValue
                    switchCell.onOffChanged = {
                        (uiSwitch) in
                        GeneralProperties.DaltonismoValue = uiSwitch.isOn
                    }
                    colorables.append(switchCell.onOff)
                    cell = switchCell
                }
            }
        }
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43.5
    }
}
