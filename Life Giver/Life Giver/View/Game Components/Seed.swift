//
//  Seed.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 16/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class Seed : UIImageView, AffectedByDynamics{
    public lazy var path: UIBezierPath = UIBezierPath(rect: self.frame)
    public var affectedByGravity: Bool = true
    public var stationary: Bool = false
    public var categoryBitMask: UInt32 = GeneralProperties.seedCategoryBitMask
    public var collisionBitGroup: UInt32 = 0x1
    public var contactBitMask: UInt32 = GeneralProperties.vaseCategoryBitMask
    
    public var value:Int = 0
    
    public static let dimensions:CGSize = CGSize(width: 34, height: 54)
}
