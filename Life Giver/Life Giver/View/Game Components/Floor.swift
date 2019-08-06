//
//  File.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 26/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class Floor : UIView, AffectedByDynamics{
    public lazy var path: UIBezierPath = UIBezierPath(rect: self.frame)
    public var affectedByGravity: Bool = false
    public var stationary: Bool = false
    public var categoryBitMask: UInt32 = GeneralProperties.floorCategoryBitMask
    public var collisionBitGroup: UInt32 = 0x1 << 1
    public var contactBitMask: UInt32 = GeneralProperties.appleCategoryBitMask | GeneralProperties.dropletCategoryBitMask
    
    public static let dimensions:CGSize = CGSize(width: Int.max, height: 40)
}
