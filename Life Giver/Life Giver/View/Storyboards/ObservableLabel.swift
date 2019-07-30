//
//  ObservableLabel.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 30/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class ObservableLabel:UILabel{
    public var delegate:LabelTextChangedDelegate?
    public override var text: String?{
        didSet{
            delegate?.textChanged(text: text)
        }
    }
}
