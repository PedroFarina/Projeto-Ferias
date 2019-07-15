//
//  ViewController.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 14/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class MainMenuViewController : UIViewController {
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgPlay: UIImageView!
    @IBOutlet var imgCog: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        lblTitle.textColor = GeneralProperties.redColor
        imgPlay.image = UIImage(named: GeneralProperties.playPath)
        imgCog.image = UIImage(named: GeneralProperties.cogPath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

