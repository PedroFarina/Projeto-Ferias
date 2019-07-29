//
//  PhysicsImageView.swift
//  UIGameKit
//
//  Created by Pedro Giuliano Farina on 26/06/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

@IBDesignable public class DynamicImageView : UIImageView, AffectedByDynamics{
    public lazy var path: UIBezierPath = UIBezierPath(rect: self.frame)
    @IBInspectable public var affectedByGravity:Bool = true
    @IBInspectable public var categoryBitMask:UInt32 = 1
    @IBInspectable public var collisionBitGroup:UInt32 = 0
    @IBInspectable public var contactBitMask:UInt32 = 0
    @IBInspectable public var stationary: Bool = false
}
