//
//  PhysicsShapeView.swift
//  UIGameKit
//
//  Created by Pedro Giuliano Farina on 26/06/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

@IBDesignable public class DynamicShapeView : ShapeView, AffectedByDynamics{
    private lazy var framePath:UIBezierPath = UIBezierPath(rect: self.frame)
    public var path: UIBezierPath{
        get{
            if let currentPath = currentPath{
                return currentPath
            }
            else{
                return framePath
            }
        }
    }
    @IBInspectable public var affectedByGravity: Bool = true
    @IBInspectable public var categoryBitMask: UInt32 = 1
    @IBInspectable public var collisionBitGroup: UInt32 = 0
    @IBInspectable public var contactBitMask: UInt32 = 0
    @IBInspectable public var stationary: Bool = false
    
    public override var collisionBoundsType: UIDynamicItemCollisionBoundsType{
        get{
            if let _ = currentPath{
                return .path
            }
            else{
                return .rectangle
            }
        }
    }
    
    public override var collisionBoundingPath: UIBezierPath{
        get{
            if let p = currentPath{
                return p
            }
            return UIBezierPath()
        }
    }
}
