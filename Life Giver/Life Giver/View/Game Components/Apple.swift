//
//  Apple.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 16/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class Apple : UIImageView, AffectedByDynamics{
    public lazy var path: UIBezierPath = UIBezierPath(arcCenter: self.center, radius: self.frame.height/2, startAngle: CGFloat.zero, endAngle: 2 * CGFloat.pi, clockwise: false)
    public var affectedByGravity: Bool = true
    public var stationary: Bool = false
    public var categoryBitMask: UInt32 = GeneralProperties.appleCategoryBitMask
    public var collisionBitGroup: UInt32 = 0x1
    public var contactBitMask: UInt32 = GeneralProperties.dropletCategoryBitMask | GeneralProperties.floorCategoryBitMask
    
    public var value:Int = 0
    
    public static let dimensions:CGSize = CGSize(width: 36, height: 40)
}
