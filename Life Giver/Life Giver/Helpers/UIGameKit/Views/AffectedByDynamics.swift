//
//  AffectedByDynamics.swift
//  UIGameKit
//
//  Created by Pedro Giuliano Farina on 26/06/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public protocol AffectedByDynamics : UIView{
    var affectedByGravity:Bool { get set }
    var stationary:Bool { get set }
    var categoryBitMask:UInt32 { get set }
    var collisionBitGroup:UInt32 { get set }
    var contactBitMask:UInt32 { get set }
    var path:UIBezierPath { get }
}
