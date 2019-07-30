//
//  FooterView.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 30/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class FooterView : UIView, LabelTextChangedDelegate{
    public lazy var lbl:ObservableLabel = ObservableLabel(frame: self.frame)
    
    public override func draw(_ rect: CGRect) {
        if lbl.superview == nil{
            addSubview(lbl)
        }
    }
    
    public override func awakeFromNib() {
        if lbl.superview == nil{
            addSubview(lbl)
        }
        lbl.isHidden = false
        lbl.frame.size = self.frame.size - CGSize(width: 20, height: 10)
        lbl.center = self.center
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        lbl.delegate = self
    }
    
    public func textChanged(text: String?) {
        self.frame.size = lbl.frame.size + CGSize(width: 20, height: 10)
        lbl.center = self.center
    }
}
