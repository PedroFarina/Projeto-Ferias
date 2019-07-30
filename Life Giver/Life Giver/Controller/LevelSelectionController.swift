//
//  LevelSelectionController.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 23/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class LevelSelectionController : UIViewController, LevelSelectedDelegate{
    private var level:Level?
    private var levelFinishedDelegate:LevelFinishedDelegate?
    
    public override func viewWillAppear(_ animated: Bool) {
        guard let navigationController = navigationController else{
            return
        }
        navigationController.navigationBar.tintColor = GeneralProperties.blueColor
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let collectionView = segue.destination as? LevelSelectionCollectionViewController{
            collectionView.selectionDelegate = self
            levelFinishedDelegate = collectionView
        }
        else if let levelController = segue.destination as? LevelController{
            levelController.level = level
            levelController.delegate = levelFinishedDelegate
        }
    }
    
    public func levelSelected(_ level:Level) {
        self.level = level
        performSegue(withIdentifier: "levelSelected", sender: self)
    }
}
