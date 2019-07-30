//
//  ViewController.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 14/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class MainMenuViewController : UIViewController {
    private var resized:Bool = false
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgPlay: UIImageView!
    @IBOutlet var imgPlayHeight: NSLayoutConstraint!
    @IBOutlet var imgCog: UIImageView!
    @IBOutlet var imgCogHeight: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        lblTitle.textColor = GeneralProperties.redColor
        imgPlay.image = UIImage(named: GeneralProperties.playPath)
        imgCog.image = UIImage(named: GeneralProperties.cogPath)
        if !resized{
            let proportionalFontSize = SizeAdapter.getTrebuchetProportionalFontSize(lblTitle.font.pointSize, deviceSize: view.frame.size)
            lblTitle.font = lblTitle.font.withSize(proportionalFontSize)
            imgPlayHeight.constant = SizeAdapter.getProportionalSize(imgPlay, deviceSize: view.frame.size).height
            imgCogHeight.constant = SizeAdapter.getProportionalSize(imgCog, deviceSize: view.frame.size).height
            resized = true
        }
        guard let navigationController = navigationController else{
            return
        }
        
        navigationController.navigationBar.tintColor = GeneralProperties.blueColor
    }
    
}

