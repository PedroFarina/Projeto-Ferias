//
//  LevelSelectionCollectionViewController.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 15/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
public class LevelSelectionTableViewController : UITableViewController, LevelFinishedDelegate{
    private var levels:[Level] = []
    public var selectionDelegate:LevelSelectedDelegate?
    
    public override func viewDidLoad() {
        reloadData()
    }
    
    public func levelFinished(level:Level) {
        reloadData()
        levels[Int(level.id)] = level
        let indexPath:IndexPath = IndexPath(item: Int(level.id), section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as? LevelSelectionTableViewCell{
            cell.completion = level.completion
            if level.id+1 != levels.count{
                tableView.cellForRow(at: IndexPath(row: Int(level.id + 1), section: 0))?.isHidden = false
            }
            var itemsAt:[IndexPath] = []
            if level.id == GeneralProperties.colorLevelID{
                if let ip = tableView.indexPathsForVisibleRows{
                    itemsAt = ip
                }
            }
            else{
                itemsAt.append(indexPath)
            }
            tableView.reloadRows(at: itemsAt, with: .top)
        }
        
    }
    
    public func reloadData(){
        levels = ModelController.shared().getLevels()
        tableView.reloadData()
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levels.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {var cell:UITableViewCell = UITableViewCell()
        if let lvCell = tableView.dequeueReusableCell(withIdentifier: "levelCell", for: indexPath) as? LevelSelectionTableViewCell{
            let selectedLevel:Level = levels[indexPath.row]
            
            lvCell.lblLevel.text = "\(selectedLevel.id + 1)"
            lvCell.completionBadge.borderColor = GeneralProperties.lightblueColor
            lvCell.completion = selectedLevel.completion
            lvCell.awakeFromNib()
            if indexPath.row != 0{
                lvCell.isHidden = levels[indexPath.row - 1].completion == 0
            }
            else{
                lvCell.isHidden = false
            }
            cell = lvCell
        }
        return cell
        
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionDelegate?.levelSelected(levels[indexPath.row])
    }
}
