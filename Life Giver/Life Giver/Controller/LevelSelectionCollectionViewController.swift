//
//  LevelSelectionCollectionViewController.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 15/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
public class LevelSelectionCollectionViewController : UICollectionViewController{
    public override func viewDidLoad() {
        
        Bundle.main.localizedString(forKey: "Level", value: nil, table: "Levels")
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}
