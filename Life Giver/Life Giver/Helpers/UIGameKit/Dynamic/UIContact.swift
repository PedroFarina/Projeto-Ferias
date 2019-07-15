//
//  UIContact.swift
//  UIGameKit
//
//  Created by Pedro Giuliano Farina on 26/06/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class UIContact{
    public let item1:UIDynamicItem
    public let item2:UIDynamicItem
    public let p:CGPoint
    
    public let behavior:UICollisionBehavior
    
    internal init(behavior:UICollisionBehavior, item1:UIDynamicItem, item2:UIDynamicItem, at p:CGPoint){
        self.behavior = behavior
        self.item1 = item1
        self.item2 = item2
        self.p = p
    }
}
