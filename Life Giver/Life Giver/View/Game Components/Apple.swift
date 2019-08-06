//
//  Apple.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 16/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class Apple : UIImageView, AffectedByDynamics{
    public lazy var path: UIBezierPath = UIBezierPath(rect: self.frame)
    public var affectedByGravity: Bool = true
    public var stationary: Bool = false
    public var categoryBitMask: UInt32 = GeneralProperties.appleCategoryBitMask
    public var collisionBitGroup: UInt32 = 0x1 << 1
    public var contactBitMask: UInt32 = GeneralProperties.floorCategoryBitMask | GeneralProperties.vaseCategoryBitMask
    
    public var value:Int = 0
    
    public static let dimensions:CGSize = CGSize(width: 36, height: 40)
}
