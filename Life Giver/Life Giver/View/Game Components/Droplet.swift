//
//  Droplet.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 16/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class Droplet : UIImageView, AffectedByDynamics{
    public lazy var path: UIBezierPath = UIBezierPath(rect: self.frame)
    public var affectedByGravity: Bool = true
    public var stationary: Bool = false
    public var categoryBitMask: UInt32 = GeneralProperties.dropletCategoryBitMask
    public var collisionBitGroup: UInt32 = 0x1
    public var contactBitMask: UInt32 = GeneralProperties.glassCategoryBitMask | GeneralProperties.vaseCategoryBitMask | GeneralProperties.floorCategoryBitMask
    
    public static let dimensions:CGSize = CGSize(width: 14, height: 21)
}
