//
//  LevelSelectionController.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 23/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class LevelSelectionController : UIViewController, LevelSelectedDelegate{
    private var levelState:String?
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let collectionView = segue.destination as? LevelSelectionCollectionViewController{
            collectionView.selectionDelegate = self
        }
        else if let levelController = segue.destination as? LevelController{
            levelController.Level = levelState
        }
    }
    
    public func levelSelected(_ levelState: String?) {
        self.levelState = levelState
        performSegue(withIdentifier: "levelSelected", sender: self)
    }
}
