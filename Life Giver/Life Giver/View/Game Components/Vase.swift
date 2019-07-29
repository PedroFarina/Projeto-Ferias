//
//  Vase.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 16/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class Vase : UIImageView, AffectedByDynamics{
    public lazy var path: UIBezierPath = UIBezierPath(rect: self.frame)
    public var affectedByGravity: Bool = false
    public var stationary: Bool = true
    public var categoryBitMask: UInt32 = GeneralProperties.vaseCategoryBitMask
    public var collisionBitGroup: UInt32 = 0x1
    public var contactBitMask: UInt32 = GeneralProperties.dropletCategoryBitMask | GeneralProperties.seedCategoryBitMask
    
    public var value:Int = 0
    public var wet:Bool = false
    
    public static let dimensions:CGSize = CGSize(width: 54, height: 59)
}
